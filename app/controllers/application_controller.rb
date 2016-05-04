class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_filter :categories, :brands

	def categories
		@categories = Category.order(:name)
	end

	def brands
		@brands = Product.pluck(:brand).sort.uniq!
		if @brands == nil
			@brand = Product.pluck(:brand).sort
		end
	end

#This is a function to access the IP of the computer that's
#accessing the application - if it's in local development,
#it will put in a hard coded IP so you can see it, mostly for
#testing
	def remote_ip
		if request.remote_ip == '127.0.0.1'
			"#{ENV['my_url']}"
		else
			request.remote_ip
		end
	end

 protected

 def configure_permitted_parameters

   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit({ roles: [] }, :email, :password, :password_confirmation, :role) }

   devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :role) }
 end

end



