class LikesController < ApplicationController

	before_action :logged_in_user

	def create
		user = User.find(params[:user_id])
		micropost = Micropost.find(params[:mpost_id])
		micropost.likedby(user)
		@mpostid = micropost.id
		@count  = micropost.likes.count
		respond_to do |format|
			format.js
		end
	end

	def destroy
		user = User.find(params[:user_id])
		micropost = Micropost.find(params[:mpost_id])
		micropost.unlikedby(user)
		@mpostid = micropost.id
		@count = Micropost.find(@mpostid).likes.count
		respond_to do |format|
			format.js
		end
	end

	
end
