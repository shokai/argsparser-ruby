#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require '../lib/ArgsParser'

parser = ArgsParser.parser
parser.bind(:help, :h, "show help")
parser.comment(:a, "a (add,sub,mul,div) b") # add comment for help
parser.comment(:b, "a (add,sub,mul,div) b")

first, params = parser.parse(ARGV)

required_params = [:a, :b]
if parser.has_option(:help) or !parser.has_params(required_params)
  puts parser.help
  puts 'e.g.  ruby math.rb add -a 5 -b 20'
  exit 1
end

# calc
a = params[:a].to_i
b = params[:b].to_i

if first == 'sub'
  method = '-'
  result = a - b 
elsif first == 'mul'
  method = '*'
  result = a * b
elsif first == 'div'
  method = '/'
  result = a.to_f / b
else
  method = '+'
  result = a + b
end

puts "#{a} #{method} #{b} = #{result}"

# show all params
p params
