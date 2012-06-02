#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'nokogiri'
require 'open-uri'

ARGF.each do |url|
  url.chomp!
  doc = Nokogiri::HTML(open(url))
  title = doc.xpath("//title").text.strip
  puts "#{url} : #{title}"
end
