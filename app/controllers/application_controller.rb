require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, 'secreterdfglihjl!@#$%Rgfvd3254r2' # on purpose
    enable :sessions
  end

  register Sinatra::Flash

  get "/" do
    erb :index
  end

  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find_by(id: session[:user_id])
		end

    #def redirect_if_not_logged_in
    #   redirect '/login' unless current_user
    #end

    def check_owner(obj)
      obj && obj.user == current_user
    end

    def redirect_if_not_owner(obj)
      redirect '/events' unless check_owner(obj)
    end

	end
end
