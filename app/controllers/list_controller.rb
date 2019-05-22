class ListController < ApplicationController

    get '/view/:id' do
        @user = User.find_by_id(session[:user_id])
            if is_logged_in?
                @items = Item.all
            erb :"/list/view"
            else
                erb :"users/error"
            end
    end

    get '/new/:id' do
        @user = User.find_by_id(session[:user_id])
            if is_logged_in?
                @items = Item.all
            erb :"/list/new"
            else
                erb :"users/error"
            end
    end

    post '/list/view' do
        @user = User.find_by_id(session[:user_id])
        @items = Item.create(name: params[:name], quantity: params[:quantity])
        # binding.pry
        @user.items << @items
        redirect 'view/:id'
    end

    get '/list/:id/edit' do
        @user = User.find_by_id(session[:user_id])
        if is_logged_in?
            @items = Item.find_by(id: params[:id])
        erb :"/list/edit"
        else
            erb :"users/error"
        end
    end
end

