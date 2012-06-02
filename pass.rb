#!/usr/bin/ruby

DATA = '~/Documents/lastpass.csv'

if ARGV.size != 1
  puts "USAGE: pass.rb <keyword>"
  Process.exit
end

system("ack #{ARGV.first} #{DATA}")
