require 'test/unit'
require 'rake_commands'

class Ls < ReturnCmd 
  @defaults = { "-a" => 1 }
end
class Find < ReturnCmd
  @defaults = { "-O1" => nil }
end
class TouchNew < SystemCmd
  @defaults = {:name => "touch" }
end
class Touch < SystemCmd ; end

class FindTest < Test::Unit::TestCase
  def test_ls
    a = Ls['"*.rb"']
    assert_equal a.make_cmd.encode("UTF-8") , "ls -a 1 \"*.rb\""
  end
  
  def test_find
    a = Find["-name *.rb"]
    assert_equal a.make_cmd.encode("UTF-8") , "find -O1 -name *.rb"
    tmp = a.to_s
    # byebug
    assert_match /basic\.rb/ , tmp
  end

  def test_newls
    a = TouchNew["foo"]
    assert_equal a.make_cmd.encode("UTF-8") , "touch foo"
    assert_true File.exists?("foo")
    File.unlink("foo") if File.exists?("foo")
  end

  def test_touch
    a = Touch["foo"]
    assert_true File.exists?("foo")
    File.unlink("foo") if File.exists?("foo")
  end

  def teardown
    File.unlink("foo") if File.exists?("foo")
  end
end

