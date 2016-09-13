require 'rubygems'

gem 'rake'
gem 'chronic'
require 'byebug'

class GlobalCommand
  attr_reader :message
  attr_reader :name
  attr_reader :logger
  attr_reader :level
  
  def self.[]( *args, raw )
    tmpargs = Hash[*args]
    @args = tmpargs
    if ! tmpargs.has_key?(:name)
      @name = self.to_s.downcase
    end
    if ! tmpargs.has_key?(:message)
      @message = "Running "
    end
    @raw = raw
    self.runit( @raw )
  end

  def initialize(cmd)
    @cmd = cmd
  end

  # need to make this generic 
  # and overrideable with 
  # meta-programming
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


