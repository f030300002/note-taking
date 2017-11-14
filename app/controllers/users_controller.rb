class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash.now[:success] = 'create user succeed!'
      log_in @user
      current_user
      redirect_to user_path @user
    else
      flash.now[:warning] = 'create user failed!'
      render 'new'
    end
  end

  def show
    @user = User.find(user_id)
    @user.total_amount(user_id)
  end

  def edit
    @user = User.find(user_id)
  end

  def update
    @user = User.find(user_id)
    if @user.update(user_params)
      flash.now[:success] = 'update user succeed!'
      redirect_to user_path @user
    else
      flash.now[:warning] = 'update user failed!'
      render 'edit'
    end
  end

  def destroy
    @user = User.find(user_id)
    @user.destroy
    flash.now[:success] = 'delete user succeed!'
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :amount)
  end

  def user_id
    params[:id]
  end

end
