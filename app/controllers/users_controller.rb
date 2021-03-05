class UsersController < ApplicationController

    get '/signup' do
        if session[:user_id]
            redirect "/users/#{session[:user_id]}"
        else
            erb:'/users/signup'
        end
    end
    
      post '/users' do
        user = User.create(
            :username => params[:user_name], 
            :password => params[:password],
            :first_name => params[:first_name],
            :last_name => params[:last_name]
        )

        if user.valid?
            session[:user_id] = user.id
    		redirect "/events"
  		else
            @errors = user.errors.full_messages
           
    		erb:'/users/signup'
  		end

      end
    
      get '/users/:id' do
        @user = User.find_by(id: params[:id])
        erb :'users/show'
      end
    
      get '/login' do
        if logged_in?
          redirect "/events"
        end
        erb :'users/login'
      end

      post '/login' do
		user = User.find_by(:username => params[:user_name])

		if user && user.authenticate(params[:password])
          session[:user_id] = user.id
		  redirect "/events"
		else
          @error = "Incorrect username/password. Please try again."
		  erb :'/users/login'
		end        
      end

      get '/logout' do
        session.clear
        redirect "/"
      end
end