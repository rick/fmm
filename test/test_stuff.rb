require File.expand_path(File.dirname(__FILE__) + '/test_helper.rb')

class ThingTest < Test::Unit::TestCase
  describe "a thingie" do
    it "should work" do
      lambda { raise "FAIL" }.should raise_error
    end

    it "should be pending" do
      pending("this is pending")
    end

    it "should do block pending" do
      pending("fixing") do
        flunk
      end
    end

    it "should mock" do
      thing = mock(:foo, :return => 'bar')
      thing.foo
    end
  end
end

