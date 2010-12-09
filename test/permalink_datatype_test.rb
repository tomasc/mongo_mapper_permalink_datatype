require 'test_helper'

class PermalinkDatatypeTest < ActiveSupport::TestCase

	context "Permalink.to_mongo" do
		
		should "remove whitespace" do
			assert_equal Permalink.to_mongo("Some Page Name"), "SomePageName"
			assert_equal Permalink.to_mongo("     Some        Page      Name   "), "SomePageName"
		end

		should "capitalize string" do
			assert_equal Permalink.to_mongo("poo"), "Poo"
			assert_equal Permalink.to_mongo("Some page name"), "SomePageName"
			assert_equal Permalink.to_mongo("Some pAGE name"), "SomePAGEName"
		end

		should "remove non alpha-numerical characters" do
			assert_equal Permalink.to_mongo("Some? page! n@#(a)&^me"), "SomePageName"
			assert_equal Permalink.to_mongo("Small-Paul is Here"), "SmallPaulIsHere"
		end

		should "remove accents" do
			assert_equal Permalink.to_mongo("Šarí půlenec Močil"), "SariPulenecMocil"
			assert_equal Permalink.to_mongo("MĚLČINA"), "MELCINA"
		end
		
		should "work for nil" do
			assert_nil Permalink.to_mongo(nil)
		end

		should "works for space" do
			assert_equal Permalink.to_mongo(" "), ""
		end
		
	end

end
