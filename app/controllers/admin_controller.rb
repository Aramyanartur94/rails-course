class AdminController < ApplicationController
	before_action :admin?

	def users_count
		@users_count = User.count
		render layout: 'admin'
	end
end
