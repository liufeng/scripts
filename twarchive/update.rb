#!/usr/bin/env ruby

require 'rubygems'
gem 'twitter4r', '>=0.3.0'
require 'twitter'
require 'sqlite3'

config = open('config.yml') {|f| YAML.load(f) }

db = SQLite3::Database.new(config['database'])
db.execute("DROP TABLE IF EXISTS tmp;")
db.execute("DROP TABLE IF EXISTS new;")
db.execute("CREATE TABLE IF NOT EXISTS tmp(id INTEGER PRIMARY KEY, username TEXT, post_at DATETIME, tweet VARCHAR(150));")

client = Twitter::Client.new(:login => config['username'], :password => config['password'])

client.timeline_for(:friend, :count => config['increment_amount']) do |status|
  db.execute("INSERT INTO tmp VALUES (#{status.id}, '#{status.user.screen_name}', '#{status.created_at}', '#{status.text.gsub(/'/, '\'\'')}');")
end

db.execute("CREATE TABLE new AS SELECT * FROM entries UNION SELECT * FROM tmp;")
db.execute("DROP TABLE tmp")
db.execute("DROP TABLE entries")
db.execute("CREATE TABLE entries AS SELECT * FROM new")
db.execute("DROP TABLE new")

db.close
