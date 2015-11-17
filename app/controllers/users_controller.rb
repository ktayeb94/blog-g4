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
      redirect_to edit_user_path,
                  notice: t('flash_messages.updated', :resource_name => i18n_model_name(@user))
    else
      render :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:username)
  end
end
