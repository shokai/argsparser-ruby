#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'ArgsParser'
require File.dirname(__FILE__)+'/../lib/ArgsParser'

parser = ArgsParser.parser
parser.bind(:help, :h, "show help")
parser.comment(:a, "a + b") # add comment for help
parser.comment(:b, "a + b")

parser.parse(ARGV)
params = parser.params
required_params = [:a, :b]

if parser.has_option(:help) or !parser.has_params(required_params)
  puts parser.help
  puts 'e.g.  ruby sum.rb -a 5 -b 20'
  exit 1
end

a = parser.params[:a].to_i
b = parser.params[:b].to_i
puts "#{a} + #{b} = #{a+b}"

# show all params
p parser.params
