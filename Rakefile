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
    `find #{hargs}`
  end
  # def self.|(arg)
  #   puts "Whatever"
  # end

end


desc "Run the Unit Tests"
task :test do |t|
  puts Find['. -name "*.class"'] 
  # puts Find| 2
end

