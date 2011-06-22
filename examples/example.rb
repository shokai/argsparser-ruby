#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems'
#require 'ArgsParser'
require File.dirname(__FILE__)+'/../lib/ArgsParser'

parser = ArgsParser.parser
parser.bind(:help, :h, "show help")
parser.bind(:frame, :f, "frame image (required)")
parser.bind(:message, :m, "message (required)", 'hello!!') # name, shortname, comment, default
parser.bind(:size, :s, "size (required)")
parser.comment(:min, "minimum size")
parser.comment(:max, "maximum size")
parser.comment(:debug, "debug mode", false) # name, comment, default

first, params = parser.parse(ARGV)
required_params = [:frame, :size]

if parser.has_option(:help) or !parser.has_params(required_params)
  puts parser.help
  puts 'required params'
  (required_params - params.keys).each{|param|
    puts " -#{param}"
  }
  puts 'e.g.  ruby example.rb -f frame.png -m "hello world" -s 320x240 -debug'
  puts '-'*30
  exit 1
end

if first
  puts 'first arg : ' + first
end

if parser.has_param(:size)
  puts 'size : ' + params[:size]
end

# show all params
p params
