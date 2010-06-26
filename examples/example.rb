#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require '../lib/ArgsParser'

parser = ArgsParser.parser
parser.bind(:help, :h, "show help")
parser.bind(:frame, :f, "frame image (required)")
parser.bind(:message, :m, "message (required)") # name, shortname, comment for help
parser.bind(:size, :s, "size (required)")
parser.comment(:min, "minimum size") # add comment for help
parser.comment(:max, "maximum size")
parser.comment(:debug, "debug mode")

first, params = parser.parse(ARGV)
required_params = [:frame, :message, :size]

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
