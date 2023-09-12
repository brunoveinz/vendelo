class UserMailer < ApplicationMailer

  def welcome
    @user = params[:user]
    @username = @user.username

    mail to: @user.email
  end

end
