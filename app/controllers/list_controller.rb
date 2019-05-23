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
        redirect to :"/view/:id"
    end

    get '/list/:id/edit' do
        @user = User.find_by_id(session[:user_id])
        # binding.pry
        if is_logged_in?
            binding.pry
            @items = Item.find_by(id: params[:id])

        erb :"/list/edit"
        else
            erb :"users/error"
        end
    end

    patch '/list/:id' do
        @user = User.find_by_id(session[:user_id])
        if is_logged_in?
            @items.update(params[:items])
            # binding.pry
            redirect to :"/view/:id"
        else
            erb :"users/error"
        end
    end
end

