class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      user.online = true
      if user.save
        ActionCable.server.broadcast "user_channel", {user: user, online_toggle: true, color_toggle: false}        
      end     
      flash[:success] = "Logged in successfully"
      redirect_to root_path       
    else
      flash[:error] = "There was something wrong with your login details"
      redirect_to login_path
    end
  end

  def destroy
    user = User.find_by(id: session[:user_id])    
    session[:user_id] = nil
    user.online = false
    if user.save
      ActionCable.server.broadcast "user_channel", {user: user, online_toggle: true, color_toggle: false}
    end
    flash[:success] = "Logged out"
    redirect_to login_path    
  end

  private
end