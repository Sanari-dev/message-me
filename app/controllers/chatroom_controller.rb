class ChatroomController < ApplicationController
  before_action :require_user

  def index    
    @message = Message.new
    @messages = Message.custom_display
    @users = User.where(online: true).where.not(username: current_user.username)
    @select_color = "select_color"
    @color = ["Red", "Orange", "Yellow", "Olive", "Green", "Teal", "Blue", "Violet", "Purple", "Pink", "Brown", "Grey"]
  end

  def update_color
    user = User.find_by(id: session[:user_id])
    last_color = user.color.downcase
    user.color = params[:select_color][:color].downcase
    if user.save
      ActionCable.server.broadcast "user_channel", {user: user, online_toggle: false, color_toggle: true, last_color: last_color}        
    end
  end
end