require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael)
	end

	test "unsuccessful edit" do 
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), user: {
			name: "",
			email: "",
			password: "",
			password_confirmation: ""
		}
		assert_template "users/edit"
	end

	test "Successful edit" do
		log_in_as(@user) 
		get edit_user_path(@user)
		assert_template 'users/edit'

		name = "Sample Name"
		email = "sample@gmail.com"

		patch user_path(@user), user: {
			name: name,
			email: email,
			password: "",
			password_confirmation: ""
		}

		assert_not flash.empty?
		assert_redirected_to @user
		@user.reload
		assert name, @user.name
		assert email, @user.email
	end

	test "Successful edit with friendly forwarding" do
		get edit_user_path(@user)
		log_in_as(@user)
		assert_redirected_to edit_user_path(@user)

		name = "Sample Name"
		email = "sample@gmail.com"

		patch user_path(@user), user: {
			name: name,
			email: email,
			password: "",
			password_confirmation: ""
		}

		assert_not flash.empty?
		assert_redirected_to @user
		@user.reload
		assert name, @user.name
		assert email, @user.email
	end

end
