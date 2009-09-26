#!/usr/bin/env ruby

=begin

==INTRODUCTION

This is a tool for helping me to do my my cryptography assignments.
It's purpose is to find out the English words that match the provided
pattern.

==USAGE

To run this script, you have to put a `words.txt' file under the same
path of this file. It contains an English word each line. You can get
the file by running my another script:
http://github.com/liufeng/scripts/blob/master/words.rb

Then you can run the script in this way:

$ ruby match.rb <pattern>

<pattern> is the pattern you want to match. For example, 'TOO' will
match words like 'all', 'off', 'see', etc. <pattern> is not case
sensitive, and quotation marks are not needed.

==TODO

The way that read the words file and hash the words each time is not
very effective. I may use some other way to store the words (like
database). Suggestions are welcome!

==AUTHOR

Feng Liu<liufeng@cnliufeng.com>

==VERSION

First published on Sep 26, 2009.

=end

def proc(cpt)
  @text = cpt.downcase

  now = 'A'
  already = Array.new
  @text.split(//).each do |letter|
    if !already.include?(letter) && letter == letter.downcase
      @text.gsub!(/#{letter}/, now)
      already << letter
      now.next!
    end
  end
  @text
end

words = Hash.new

File.open("words.txt", "r").each_line do |line|
  line.chomp!
  if words[proc(line)].class == Array
    words[proc(line)] << line
  else
    words[proc(line)] = [line]
  end
end

crypto = ARGV[0]

res = words[proc(crypto)]

if res
  puts res
else
  puts "Not Found."
end
