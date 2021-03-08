class UsersController < ApplicationController
    get '/users' do
      redirect_if_not_logged_in
      @users = User.all
      erb :"/users/index"
    end

    get '/signup' do
        if session[:user_id]
            redirect "/users/#{session[:user_id]}"
        else
            erb:'/users/signup'
        end
    end
    
      post '/users' do
        @errors = []
        if params[:user][:username] == ""
            @errors << "User name cannot be empty"
        end
        if params[:user][:password] == ""
            @errors << "Password cannot be empty"
        end
        if params[:user][:first_name] == ""
            @errors << "First name cannot be empty"
        end
        if params[:user][:last_name] == ""
            @errors << "Last name cannot be empty"
        end
        if @errors.count > 0
    		  erb:'/users/signup'
        else
          user = User.create(params[:user])

            if user.valid?
                session[:user_id] = user.id
                redirect "/events"
            else
                @errors = user.errors.full_messages
            
                erb:'/users/signup'
            end
        end
      end
    
      get '/users/:id' do
        redirect_if_not_logged_in
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