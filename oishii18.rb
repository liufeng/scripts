#!/usr/bin/env ruby

=begin
==INTRODUCTION

This script is for getting the link of the pictures from oishii18.com

==VERSION

First upload to GitHub.com on Dec 11, 2009

==USAGE

Run "ruby oishii18.rb <link>" (i.e. "ruby oishii18.rb
http://www.oishii18.com/jav/mika-orihara/mika-orihara-in-a-shiny-swimsuit/")
and it will print the link of the pictures in lines. Then you can
download the pictures use tools like wget. (Recommendation: run this
program by adding "> links.txt" at the end of the command line, and
run "wget -i links.txt" do download the pictures in batch.)

Internet connection is required. :-)

Enjoy!

-Feng <liufeng@cnliufeng.com>
=end

require 'rubygems'
require 'open-uri'
require 'nokogiri'

url = ARGV[0]
page = Nokogiri::HTML(open(url))
lines = page.to_s.split(/\n/)

lines.each do |line|
  puts "http://www.oishii18.com" + $1 if line =~ /<img src="(.*)" alt=/
end
