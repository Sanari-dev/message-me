class SessionsController < ApplicationController
before_action :logged_in_redirect, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in successfully"
      redirect_to root_path
    else
      flash[:error] = "There was something wrong with your login details"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out"
    redirect_to login_path
  end
end