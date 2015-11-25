require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: "User", email: "user@gmail.com", password: "foobar", password_confirmation: "foobar")
	end

	test "should be valid" do
		assert @user.valid?
	end

	test "should be present" do 
		@user.name = "    "
		assert_not @user.valid?
	end

	test "name should not be too long" do
		@user.name  = "a" * 51
		assert_not @user.valid?
	end

	test "email should not be too long" do
		@user.email = "a" * 244 + "@example.com"
		assert_not @user.valid?
	end

	test "email validation should reject invalid addresses" do
	    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
	                           foo@bar_baz.com foo@bar+baz.com]
	    invalid_addresses.each do |invalid_address|
	    	@user.email = invalid_address
	      	assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
		end
	end

    test "email address should be unique" do
    	duplicate_user = @user.dup
    	@user.save
    	assert_not duplicate_user.valid?
    end

    test "password should be present (non blank)" do
    	@user.password = @user.password_confirmation = " " * 6
    	assert_not @user.valid?
    end

    test "password should have a minimum length" do
    	@user.password = @user.password_confirmation = "a" * 5
    	assert_not @user.valid?
    end

    test "authenticated? should return false for a user with nil digest" do
		assert_not @user.authenticated?(:remember,'')
	end

	test "associated microposts should be destroyed" do
		@user.save
		@user.microposts.create!(content: "Sample Post")
		assert_difference 'Micropost.count', -1 do
			@user.destroy
		end
	end

	test "should follow and unfollow an user" do
		michael = users(:michael)
		kamal = users(:vijay)
		assert_not michael.following?(kamal)
		michael.follow(kamal)
		assert michael.following?(kamal)
		assert kamal.followers.include?(michael)
		michael.unfollow(kamal)
		assert_not michael.following?(kamal)
	end

	test "should see right posts" do
		# k => M, k=>k, k=/=>aj	

		kamal = users(:kamal)
		ajit = users(:ajit)
		michael = users(:michael)

		michael.microposts.each do 	|post_following|
			assert kamal.feed.include?(post_following)
		end

		kamal.microposts.each do |post_self|
			assert kamal.feed.include?(post_self)
		end

		ajit.microposts.each do |post_unfollowed|
			assert_not kamal.feed.include?(post_unfollowed)
		end

	end

end
