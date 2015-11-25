require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  
	def setup
		@user = users(:michael)
		# @micropost = Micropost.new(content: "Sample Content", user_id: @user.id)
		@micropost = @user.microposts.build(content: "Sample Content")
	end

	test "Post should be valid" do
		assert @micropost.valid?
	end

	test "User ID should be present" do
		@micropost.user_id = nil
		assert_not @micropost.valid?
	end

	test "Content should be present " do
		@micropost.content = ""
		assert_not @micropost.valid?
	end

	test "Content should be at most 140 chars" do
		@micropost.content = "a" * 141
		assert_not @micropost.valid?		
	end

	test "order should be most recent first" do
		assert_equal microposts(:latest),Micropost.first
	end

end
