class UsersController < ApplicationController
	
	def index
    	@users = User.all
  	end

	def login
    	render 'login'
  end

  def signup
      render 'signup'
  end

  def logout
    reset_session
    redirect_to root_path
  end

  def new
    user = User.new(user_params)
    if(user.save)
      session[:current_user_name] = user[:username]
      session[:current_user_id] = user[:id]
      redirect_to articles_path
    else
      redirect_to root_path
    end
  end

 	def check
 		@user = user_params
 		@users = User.all
 		@flag = 1
 		@users.each do |users|
      		if(users[:username].eql? @user[:username] and users[:password].eql? @user[:password])
            session[:current_user_id] = @user[:id]
      			session[:current_user_name] = @user[:username]
      			redirect_to articles_path
      			@flag = 0
      			break
    		end
    	end
    	if(@flag==1)
    		redirect_to root_path
    	end
 	end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
    end


  	private
    	def user_params
      		params.permit(:id, :username, :password)
    	end
end
