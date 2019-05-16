class UserController < ApplicationController

    get '/signup' do
        erb :'users/signup'
    end

    post '/users/signup' do
    end

    get '/login' do
        erb :'/users/login'
    end

    post '/login' do
        @user = User.find_by(:username => params[:username])
        if @user != nil && @user.password == params[:password]    
          session[:user_id] = @user.id
          redirect to "/user/#{@user.id}"
        end
          erb :error
          #need error page
    end

    get '/users/:id' do
        @user = User.find_by_id(session[:user_id])
    if Helpers.is_logged_in?(session)
      erb :account
    else
      erb :error
    end

    end

end