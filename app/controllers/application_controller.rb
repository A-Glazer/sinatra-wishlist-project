require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "shopping"
  end

  get "/" do
    erb :welcome
  end


  helpers do

    def current_user
        @user = User.find_by_id(session[:user_id])
    end

    def is_logged_in?
        # !!session[:user_id]
        !!current_user
    end
  end
end


