#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('http://www.paulnoll.com/Books/Clear-English/words-01-02-hundred.html'))

doc.css('ol > li').each do |link|
  puts link.content
end