class RoomsController < ApplicationController
  def index
    if !current_user.nil?
      @room = Room.new
      @current_user = current_user
      # @single_room = Room.find(params[:id])
      @rooms = Room.public_rooms
      @users = User.all_except(@current_user)
      render 'index'
    else
      redirect_to signin_path
    end
  end

  def show
    @current_user = current_user
    @single_room = Room.find(params[:id])
    @message = Message.new
    @messages = @single_room.messages
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
    render 'index'
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.create(name: params['room']['name'])
  end
end
