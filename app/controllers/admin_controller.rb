class AdminController < ApplicationController

	before_filter :authenticate_user!

  def users
  	@users = User.all

  	if params[:promotion] == "up"
  		user = User.find(params[:id])
  		user.update(role: "admin")
  	elsif params[:promotion] == "down"
  		user = User.find(params[:id])
  		user.update(role: "guest")
  	end
  end

end
