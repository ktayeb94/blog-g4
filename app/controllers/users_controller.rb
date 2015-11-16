class UsersController < ApplicationController

  before_action :authenticate_user!

  # GET  /user/edit
  def edit
    @user = current_user
  end

  # PATCH/PUT /user/
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to edit_user_path, notice: 'Settings sucessfully updated'
    else
      render :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:blog_name)
  end
end