require 'test_helper'

class RelationshipsControllerTest < ActionController::TestCase

	test "redirect create if user not logged in" do
		assert_no_difference 'Relationship.count' do
			post :create
		end	
		assert_redirected_to login_url
	end

	test "redirect destroy if user not logged in" do
		assert_no_difference 'Relationship.count' do
			delete :destroy, id: relationships(:one)
		end	
		assert_redirected_to login_url
	end

end
