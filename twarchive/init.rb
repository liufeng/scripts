#!/usr/bin/env ruby

require 'rubygems'
gem 'twitter4r', '>=0.3.0'
require 'twitter'
require 'sqlite3'

config = open('config.yml') {|f| YAML.load(f) }

db = SQLite3::Database.new(config['database'])
db.execute("CREATE TABLE IF NOT EXISTS entries(id INTEGER PRIMARY KEY, username TEXT, post_at DATETIME, tweet VARCHAR(150));")

client = Twitter::Client.new(:login => config['username'], :password => config['password'])

client.timeline_for(:friend, :count => config['init_save_amount']) do |status|
  db.execute("INSERT INTO entries VALUES (#{status.id}, '#{status.user.screen_name}', '#{status.created_at}', '#{status.text.gsub(/'/, '\'\'')}');")
end

db.close
