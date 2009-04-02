require "test/unit"
require File.dirname(__FILE__) + "/../lib/spraytan"
require "fileutils"

class SprayTanTest < Test::Unit::TestCase
  include FileUtils
  
  def setup
    @output = {"bill-state"=>"Welcome to Google Business Solutions", "links"=>["/", "https://adwords.google.com/select/Login?sourceid=awo&subid=us-en-et-bizsol-0-biz1-all&medium=link&hl=en_US"]}
    @links = ParseletLinks.new(:parselets => File.dirname(__FILE__) + "/foo.let")
  end
  
  def test_bill_state
    bills = File.dirname(__FILE__) + "/bills.csv"
    @links.walk @output
    assert_equal File.read(File.dirname(__FILE__) + "/expected.csv"), File.read(bills)
    rm bills
  end
end

