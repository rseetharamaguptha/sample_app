require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  
	def setup
		@like = Like.create(micropost_id:1, user_id: 1)
	end

	test "Valid user_id, mp_id" do
		assert @like.valid?
	end

	test "null user id" do
		@like.user_id = nil
		assert_not @like.valid?
	end

	test "null mp id" do
		@like.micropost_id = nil
		assert_not @like.valid?
	end

end
