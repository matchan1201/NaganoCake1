class Public::EndUsersController < ApplicationController
  def show
  	@end_user = current_end_user
  end

  def edit
  	@end_user = current_end_user
  end

  def update
  	@end_user = current_end_user
  	if @end_user.update(end_users_params)
  	   redirect_to end_users_path
    else
    render :edit
  end
  end

  def withdrawal
    end_user = current_end_user
    end_user.destroy
    redirect_to root_path
  end

  def confirm
  end

  private
  def end_users_params
  	params.require(:end_user).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :phone_number)
  end
end
