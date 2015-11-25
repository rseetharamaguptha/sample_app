require 'test_helper'

class MicropostsControllerTest < ActionController::TestCase
   
	def setup
		@micropost = microposts(:one)
	end

	test "redirect micropost create if not logged in" do
		assert_no_difference 'Micropost.count' do
			post :create, micropost: { content: "Sample Content" }
		end
		assert_redirected_to login_url
	end

	test "redirect micropost delete if not logged in" do
		assert_no_difference 'Micropost.count' do
			delete :destroy, id: @micropost
		end
		assert_redirected_to login_url
	end

	test "should redirect delete if micropost not belong to current user" do
		user = users(:michael)
		log_in_as user
		micropost = microposts(:van)
		assert_no_difference 'Micropost.count' do 
			delete :destroy, id: @micropost
		end
		assert_redirected_to root_url
	end

end
