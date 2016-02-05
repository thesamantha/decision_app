class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])  # retrieve user with id==1 from database and store it in var @user
                                    # params is a hash identifying the various players for a particular page (controller, action, etc), and in this case "id" is one of the players, which we are selecting from the params hash and passing to User.find()
   # debugger    # activate byebug gem in development environment
  end

  def new
    @user = User.new    # wir machen einen neuen User als Parameter fuer die "form_for"-Methode
  end

  def create
    @user = User.new(user_params)
    
    if @user.save     # attempt to save the user and setup possibility for "else" in one step
      flash[:success] = "Welcome to the Sample App!"    #display a message upon sucess that will disappear upon navigation/page refresh
      redirect_to user_url(@user)     #redirect to url with parameters of @user (I'm guessing)
    else
      render 'new'
    end
  end


  private

    def user_params   # only name, email, pass, and pass_conf are permitted. user attribute required.
      params.require(:user).permit(:name, :email, :password, :password_confirmation)  #returns version of *params* hash with only permited attributes (raising an error if :user attribute is missing)
    end

end
