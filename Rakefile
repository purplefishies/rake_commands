require 'rubygems'

gem 'rake'
gem 'chronic'


class Find
  def initialize(*args)
    hargs = Hash[args]
    findit( hargs )
    @files = []
  end

  def findit
    @files = `find #{hargs}`.split("\n")
  end

  def to_a
    @files
  end
end

class SourceFiles
end



desc "Run the Unit Tests"
task :test do |t|
  puts "Foo"
  puts t.methods
end

