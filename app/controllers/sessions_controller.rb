class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])     #user will be true only if User.find_by was successful; user.authenticate only if password is correct
      # Log the user in and redirect to the user's show page.
      log_in user   # method we defined in SessionsHelper
      redirect_to user_url(user)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'    #so you just get thrown back to new if it doesn't work out
    end
  end

  def destroy
  end
end
