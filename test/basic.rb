require 'test/unit'
require 'rake/command'

class Ls < ReturnCmd 
  @defaults = { "-a" => 1 }
end
class Find < GlobalCommand
  @defaults = { "-01" => nil }
end
class TouchNew < SystemCmd
  @defaults = {:name => "touch" }
end

class FindTest < Test::Unit::TestCase
  def test_ls
    a = Ls['"*.rb"']
    assert_equal a.make_cmd.encode("UTF-8") , "ls -a 1 \"*.rb\""
  end
  
  def test_find
    a = Find["*.rb"]
    assert_equal a.make_cmd.encode("UTF-8") , "find -01 *.rb"
  end

  def test_newls
    a = TouchNew["foo"]
    assert_equal a.make_cmd.encode("UTF-8") , "touch foo"
    assert_true File.exists?("foo")
  end
  def teardown
    File.unlink("foo") if File.exists?("foo")
  end
end

