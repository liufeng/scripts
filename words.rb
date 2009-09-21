#!/usr/bin/env ruby

=begin

==INTRODUCTION

Since I want a handy tool for helping me to do my cryptography assignments,
I need a list of common English words. There is a list of 3000 common English
words: http://www.paulnoll.com/Books/Clear-English/English-3000-common-words.html
Thought the author had removed some simple words such as ``tree'' and the amount 
of the words is much less than 3000 (only about 2000), it's the best I can find
currently.

This piece of Ruby script is for getting the English words in that list, and 
printting them as a whole list.

==AUTHOR

Feng Liu<liufeng@cnliufeng.com>

==CREDITS

I'd like to thank the authors of nokogiri library. I've got a lot of fun
when I'm using it.

I'd also like to thank the maintainer of http://www.paulnoll.com/ Your word list
is the best one I can find on the Internet.

==VERSION

The code is firstly uploaded on Sep 21, 2009.

=end

require 'rubygems'
require 'nokogiri'
require 'open-uri'

def getwords(link)
  doc = Nokogiri::HTML(open(link))

  doc.css('ol > li').each do |link|
    /^\s*(\w+)\s*$/.match(link.content)
    puts "#{$1}"
  end
end

doc = Nokogiri::HTML(open('http://www.paulnoll.com/Books/Clear-English/English-3000-common-words.html'))

baselink = 'http://www.paulnoll.com/Books/Clear-English/'

doc.css('ol > li > a').each do |link|
  getwords(baselink + link[:href])
end