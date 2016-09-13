require 'rubygems'

gem 'rake'
gem 'chronic'
require 'byebug'

class GlobalCommand
  @@attributes = {
    :message => "Running",
    :name => lambda { |slf| slf.to_s.downcase },
    :logger => 1,
    :level => nil
  }

  def self.[]( *args, raw )
    if args.length % 2 != 0 
      raise "ARGS length must be multiple of 2 "
    end
    tmpargs = Hash[*args]
    @args = tmpargs
    @@attributes.each { |i|
      if tmpargs.has_key?(i)
        if attributes[i].lambda? 
          self.class_variable_set("@@#{i}", attributes[i].call( self ) )
        else
          self.class_variable_set("@@#{i}", tmpargs[i] )
        end
      end
    }

    @raw = raw
    self.runit( @raw )
  end

  def initialize(cmd)
    @cmd = cmd
  end

  def self.runit(hargs)
    self.new("#{self.to_s.downcase} #{hargs}")
  end

  def to_s
    @entries = `#{@cmd}`.split("\n")
    @entries.join(" ")
  end


end

# doctest: Can get ls to run
# >> a = Ls["*.rb"]
# >> a.to_s 
# => "cmd.rb"
class Ls < GlobalCommand ; end



# doctest: Can get find to run
# >> a = Find['. -name "*.rb"']
# >> a.to_s 
# => "./cmd.rb"
class Find < GlobalCommand; end



# class Find
#   def self.[]( *args, raw )
#     @args = args
#     @raw  = raw
#     self.runit( @raw )
#   end

#   def initialize(cmd)
#     @cmd = cmd
#   end

#   def self.runit(hargs)
#     Find.new("find #{hargs}")
#   end

#   def to_s
#     @entries = `#{@cmd}`.split("\n")
#     @entries.join(" ")
#   end
  
#   def |(other)
#     puts "Whatever #{other}"
#   end
# end


