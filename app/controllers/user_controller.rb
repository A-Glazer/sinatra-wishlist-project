class UserController < ApplicationController

    get '/signup' do
        erb :'users/signup'
    end

    post '/users/signup' do
        if params[:username] != nil && params[:password] != nil
            @user = User.create(:username => params[:username], :password => params[:password])
            session[:user_id] = @user.id
            redirect to "/users/#{@user.id}"
        else
            erb :"users/error"
        end
    end

    get '/login' do
        erb :'/users/login'
    end

    post '/login' do
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect to "/users/#{@user.id}"
        end
          erb :"users/error"
          #need error page
    end

    get '/users/:id' do
        @user = User.find_by_id(session[:user_id])
        # binding.pry
    if is_logged_in?
      erb :"users/account"
    else
        erb :"users/error"
    end

    end

    get '/logout' do
        session.clear
        redirect :'/'
      end

end