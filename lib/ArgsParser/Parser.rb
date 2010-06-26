# -*- coding: utf-8 -*-
# ARGSのparser

class Parser

  attr_reader :params, :comments, :first

  def initialize
    @binds = Hash.new
    @comments = Hash.new
  end

  def parse(argv)
    # parse
    @first = nil
    if argv.size > 0 and !(argv.first =~ /^-+.+/)
      @first = argv.shift
    end

    @params = Hash.new
    for i in 0...argv.size do
      if argv[i].match(/^-+.+/)
        term = argv[i].match(/^-+(.+)/)[1].to_sym
        if i == argv.size-1 || argv[i+1].match(/^-+.+/)
          @params[term] = true # option
        else
          @params[term] = argv[i+1] # param
        end
      end
    end
    
    @binds.keys.each{|name|
      fullname = @binds[name]
      if @params[fullname] == nil && @params[name] != nil
        @params[fullname] = @params[name]
        @params.delete(name)
      end
    }
    
    return @first, @params
  end

  def bind(fullname, name, comment=nil)
    @binds[name.to_sym] = fullname.to_sym
    if comment != nil
      comment(fullname, comment)
    end
  end

  def has_param(name)
    @params[name].class == String
  end

  def has_params(params_arr)
    params_arr.each{|name|
      return false if !has_param(name)
    }
    return true
  end

  def has_option(name)
    @params[name] == true
  end

  def has_options(options_arr)
    options_arr.each{|name|
      return false if !has_option(name)
    }
    return true
  end

  def comment(name, comment)
    @comments[name.to_sym] = comment.to_s
  end
  
  def help
    binds_reversed = Hash.new
    most_longname_size = 0
    @binds.keys.each{|key|
      value = @binds[key]
      binds_reversed[value] = key
      if most_longname_size < len = key.to_s.size + value.to_s.size
        most_longname_size = len
      end
    }

    s = "options:\n"
    @comments.keys.sort{|a,b| a.to_s <=> b.to_s }.each{|name|
      comment = @comments[name]
      if shortname = binds_reversed[name]
        s += " -#{name} (-#{shortname})" +
          " "*(most_longname_size-name.to_s.size-shortname.to_s.size+2) + "#{comment}\n"
      else
        s += " -#{name}" + " "*(most_longname_size-name.to_s.size+6) + "#{comment}\n"
      end
    }
    return s
  end

end
