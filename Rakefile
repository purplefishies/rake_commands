require 'rubygems'

gem 'rake'
gem 'chronic'

class GlobalCommand
  attr_reader :message
  attr_reader :name
  attr_reader :logger
  attr_reader :level
  
  def self.[]( *args, raw )
    tmpargs = Hash[*args]
    @command = raw
  end

  def self.runit()
    @logger.info "#{@message} #{@command}"
  end
end


class Find
  def self.[]( *args, raw )
    @args = args
    @raw  = raw
    self.findit( @raw )
  end
  def self.findit(hargs)
    Find.new(`find #{hargs}`.split("\n"))
  end
  
  def initialize(entries)
    @entries = entries
  end

  def to_s
    @entries.join(" ")
  end
  
  def |(other)
    puts "Whatever #{other}"
  end

end


desc "Run the Unit Tests"
task :test do |t|
  files = Find['. -name "*.class"'] 
  blah = Find['. -name "*.class"'] | "foo"
  puts files.class
  puts "#{files}"
  # puts Find| 2
end

