#!/usr/bin/env ruby
require 'rubygems'

#
# This is something
#
#
#
class GlobalCommand
  @defaults = {}
  @@cmdattributes = {}
  @@attributes = {
    :message => "Running",
    :name => lambda { |slf| slf.to_s.downcase },
    :logger => 1,
    :level => nil,
  }
  
  #
  # Factory constructor
  #
  def self.[]( *args, raw )
    if args.length % 2 != 0 
      raise "ARGS length must be multiple of 2 "
    end
    @defaults ||= {}
    tmpargs = Hash[*args]
    cmdattributes = {}
    attributes = {}
    attributes = @@attributes.dup
    attributes.keys.each { |i|
      if attributes[i].class == Proc
        attributes[i] = attributes[i].call( self )
      end
    }

    @defaults.keys.each { |i| 
      if i.class == Symbol && attributes.has_key?(i)
        if @defaults[i].class == Proc
          attributes[i] = @defaults[i].call( self )
        else
          attributes[i] = @defaults[i]
        end
      elsif i.class != Symbol
        cmdattributes[i] = @defaults[i]
      end
    }

    self.buildit( attributes:attributes, cmdattributes:cmdattributes, cmd:raw )
  end

  #
  #
  #
  def make_cmd()
    cmd = @attributes[:name] + " "
    tmp = [@cmdattributes.keys.find_all { |i| @cmdattributes[i].nil? }.map { |i| i }.join(" "),
           @cmdattributes.keys.find_all { |i| !@cmdattributes[i].nil? }.map { |i| i + " " + @cmdattributes[i].to_s }.join(" "),
           @cmd].find_all { |i| i != "" }.join(" ")
    cmd += tmp
    return cmd
  end

  def initialize(args)
    @attributes = args[:attributes]
    @cmdattributes = args[:cmdattributes]
    @cmd = args[:cmd]
  end

  def self.buildit(hargs)
    self.new( hargs )
  end

end

class ReturnCmd < GlobalCommand
  def to_s
    runit()
  end
  def runit()
    @entries = `#{self.make_cmd()}`.split("\n")
    @entries.join(" ")
  end
end

class SystemCmd < GlobalCommand
  def initialize(args)
    super
    runit()
  end
  def runit()
    @entries = system("#{self.make_cmd()}")
  end
end





