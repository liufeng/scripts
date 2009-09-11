#!/usr/bin/perl -w

# Twitter -> Xiaonei status sync tool.
# Author: Feng Liu <liufeng@cnliufeng.com>
# Version: 1.0
# Date: Tue Apr 21 23:06:40 +0000 2009

# UPDATE NOTICE: Since Xiaonei has changed its name to Renren, 
# the url address is also changed. This may cause this script 
# doesn't work properly. It's very possible that I'm not going
# to take care this piece of code anymore. But you can modify 
# the code to fit the new situation. Good Luck!
# -Feng  Sep 11, 2009

use utf8;
use Encode;
use LWP::Simple;
use HTML::Entities;

####################### Settings starts here #######################
# Set your base account information here. Don't show this to others!
my $twitter_account = 'YOUR TWITTER ACCOUNT';
my $xiaonei_email = 'YOUR XIAONEI ACCOUNT';
my $xiaonei_passwd = 'YOUR XIAONEI PASSWORD';

# some machine's wget is too old, so you may need to rebuild a newer
# version and indicate the path of your own wget here.
my $wget_cmd = 'wget';

# The program needs a log file for keeping the time of your last
# tweet. Otherwise you may get your xiaonei status updated to a same
# tweet. So please keep this file!
my $logfile = '/tmp/twxn.log';
######################## Settings ends here ########################

my $twitter_url = 'http://twitter.com/statuses/user_timeline/' . $twitter_account . '.xml';
my $statuses = get($twitter_url);
my @lines = split /\n/, $statuses;
my $latest_text = $lines[5];
my $latest_time = $lines[3];

if ($latest_text =~ /<text>(.*)<\/text>/) {
    $status = $1;
};
$text = decode_entities($status);

# If the log file doesn't exist, create a new one.
if (!(-e $logfile)) {
    open LOG,"> /tmp/twxn.log" or die "ERROR: Cannot create log file.";
    close LOG;
    print "Created a new log file: $logfile\n";
}

open LOG, "< $logfile" || die "ERROR: Cannot open log file!";
$last_time = <LOG>;
close LOG;

if ($last_time ne $latest_time) {

    my $login_cmd = $wget_cmd . ' --no-proxy -O xiaoneilogin.log --post-data="email=' . $xiaonei_email . '&password=' . $xiaonei_passwd . '&autoLogin=true"  --keep-session-cookies --save-cookies=xiaoneicookie http://login.xiaonei.com/Login.do';

    my $post_cmd = $wget_cmd . ' --no-proxy -O xiaoneipost.log --post-data="c=' . $text . '"  --keep-session-cookies --load-cookies=xiaoneicookie http://status.xiaonei.com/doing/update.do --referer=http://status.xiaonei.com/getdoing.do';

    system($login_cmd);
    system($post_cmd);
    
    open LOG, "> $logfile" || die "ERROR: Cannot open log file!";
    print LOG $latest_time;
    close LOG;
}
