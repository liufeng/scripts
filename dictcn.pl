#!/usr/bin/perl -w

use utf8;
use Encode;
use LWP::Simple;

if ($#ARGV == 0) {
    $word = $ARGV[0];
} else {
    $word = shift @ARGV;
    foreach $arg (@ARGV) {
        $word .= "-" . $arg;
    }
}

my $url = "http://dict.cn/" . $word . ".htm";
my $content = decode("gbk", get $url);
@lines = split /\n/, $content;
$meaning = $lines[93];

if ($meaning =~ /<strong>(.*)<\/strong>/) {
    $_ = $1;
    s/<br \/>/\n/g;
    print encode("utf8", $_) . "\n";

    if (! /^\s$/) {
        open FILE, ">> words.txt";
        print FILE "$word\n";
        close FILE;
    }
}

__END__

=head1 NAME

dictcn.pl - A command line interface of Dict.cn

=head1 VERSION

Uploaded to GitHub.com on Sep 11, 2009.

=head1 SYNOPSIS

perl dictcn.pl <word>		# <word> can be English or Chinese

=head1 DESCRIPTION

dictcn.pl simply get the word from the command line, get the result 
page from dict.cn, and extract the translated meaning. Then dictcn.pl 
will save the original word to words.txt file for future reviewing.

=head1 LICENSE

dictcn.pl is free software; you may redistribute it and/or modify it
under the same terms as Perl itself.

=head1 AUTHOR & COPYRIGHT

Except where otherwise noted, dictcn.pl is Copyright 2009 Feng Liu, 
<liufeng@cnliufeng.com>. All rights reserved.

=cut