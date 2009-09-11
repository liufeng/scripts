#!/usr/bin/env ruby

=begin
INTRODUCTION

This script is for getting the download video from YouJizz.com

VERSION

First upload to GitHub.com on Sep 11, 2009

USAGE

1. Put the url of the video page
(ie. http://www.youjizz.com/videos/amiia-and-dani-fucked-together-138767.html)
in a text file. Each line should have one url.

2. Pass the file as the argument of this script. It will print the video links
to the STDOUT.

Internet connection is required. :)

Enjoy!

-Feng <liufeng@cnliufeng.com>
=end

require 'rubygems'
require 'open-uri'
require 'hpricot'

#url = 'http://www.youjizz.com/videos/asian-public-store-sex-138675.html'
File.open(ARGV[0]) do |file|
  while url = file.gets
    doc = Hpricot(open(url))
    lines = doc.to_s.split
    flv = Array.new
    lines.each do |line|
      flv << line if line =~ /flv/
    end
    
    result = ''
    
    flv.each do |line|
      result = line if line =~ /addVariable/
    end
    
    puts result[32..-4]
  end
end
