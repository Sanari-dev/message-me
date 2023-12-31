class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :logged_in_redirect, only: [:new, :create]
  before_action :require_user, except: [ :new, :create]
  before_action :require_valid_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the MessageMe #{@user.username}, you have successfully signed up"
      redirect_to root_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Your account information was succesfully updated"
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy    
    session[:user_id] = nil if @user == current_user
    flash[:success] = "Account successfully deleted"
    redirect_to login_path
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_valid_user
      if current_user != @user
        flash[:error] = "You can only edit or delete your own account"
        redirect_to edit_user_path(current_user)
      end
    end
end