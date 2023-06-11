class ApplicationController < ActionController::Base
	include Pagy::Backend
	
	helper_method :current_user

	private

	def current_user
		@current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
	end

	def authorize
		session[:redirect_to] = request.url
		redirect_to login_path, alert: 'You must login for creating new messages!' if current_user.nil?
	end
end