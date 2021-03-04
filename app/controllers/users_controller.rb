class UsersController < ApplicationController
    get '/signup' do
        if session[:user_id]
            redirect "/users/#{session[:user_id]}"
        else
            erb:'users/signup'
        end
    end
    
      post '/users' do
    
        u = User.create(params[:user])
        seesion[:user_id] = u.id
        redirect "/users/#{u.id}"
      end
    
      get '/users/:id' do
        @user = User.find_by(id: param[:id])
        erb :'users/show'
      end
    
      get '/login' do
        if session[:user_id]
          redirect "/users/#{session[:user_id]}"
        end
        erb :'users/login'
      end
end