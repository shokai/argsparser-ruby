$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

directory = File.expand_path(File.dirname(__FILE__))

require File.join(directory, 'ArgsParser', 'Parser')

module ArgsParser
  VERSION = '0.0.10'

  def ArgsParser.parser
    Parser.new
  end
end
