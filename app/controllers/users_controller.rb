class UsersController < ApplicationController
  def new
      @user = User.new
  end

  def create
    @user = User.new(user_params)
    redirect_to '/signup' unless @user.save
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end

  def show
    require_logged_in
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :nausea, :happiness, :tickets, :height, :admin)
  end
end
