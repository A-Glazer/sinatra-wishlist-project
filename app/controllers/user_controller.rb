class UserController < ApplicationController

    get '/signup' do
        if !is_logged_in?
            erb :'users/signup'
        else
            session[:user_id] = current_user.id
            redirect to "/users/#{@user.id}"
        end
    end

    post '/users/signup' do
        if !params[:username].empty? && !params[:password].empty?
            @user = User.create(username: params[:username], password: params[:password])
            session[:user_id] = @user.id
            redirect to "/users/#{@user.id}"
        else
            redirect to :'/signup'
        end
    end

    get '/login' do
        if !is_logged_in?
            erb :'/users/login'
        else
            session[:user_id] = current_user.id
            redirect to "/users/#{@user.id}"
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect to "/users/#{@user.id}"
        end
          erb :"users/error"
    end

    get '/users/:id' do
        @user = User.find(params[:id])
        if is_logged_in? && @user.id == current_user.id
            # session[:user_id] = current_user.id
            erb :"users/account"
        else
            erb :"users/error"
        end
    end

    get '/logout' do
        session.destroy
        redirect to '/'
    end

end