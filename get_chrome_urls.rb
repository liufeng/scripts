#!/usr/bin/env ruby

require "appscript"
include Appscript

tabs = app("Google Chrome").windows[1].get.tabs.get
tabs.each { |tab| puts " * [[#{tab.URL.get}|#{tab.title.get}]]" }
