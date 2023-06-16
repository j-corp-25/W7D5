class UsersController < ApplicationController
  before_action :require_logged_in, only: [:destroy,:show,:index,:update,:edit]
  before_action :require_logged_out, only: [:create,:new]

  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_url
    else
      render :new
    end
  end

  














  def user_params
    params.require(:user).permit(:username,:password)
  end




end
