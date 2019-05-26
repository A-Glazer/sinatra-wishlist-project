class ListController < ApplicationController

    get "/view" do
        if is_logged_in? && current_user
                session[:user_id] = current_user.id       
                @items = current_user.items
                erb :"/list/view"
            else
                erb :"users/error"
            end
    end

    get '/new' do
        if is_logged_in? && current_user
            session[:user_id] = current_user.id
                erb :"/list/new"
            else
                erb :"users/error"
            end
    end

    post '/items' do
        if is_logged_in? && current_user && !params[:name].empty? && !params[:quantity].empty?
            session[:user_id] = current_user.id       
            @item = Item.create(name: params[:name], quantity: params[:quantity])
            current_user.items << @item
            redirect to "/view"
        else
            redirect to "/new"
        end
    end

    get '/list/:id/edit' do
        if is_logged_in? && current_user
            session[:user_id] = current_user.id                   
            @item = Item.find_by(id: params[:id])
            erb :"list/edit"
        else
            erb :"users/error"
        end
    end

    patch '/list/:id' do
        if is_logged_in? && current_user && !params[:name].empty? && !params[:quantity].empty?
            session[:user_id] = current_user.id    
            @item = Item.find_by(id: params[:id])
            @item.update(name: params[:name], quantity: params[:quantity])
            redirect to "/view"
        else
            erb :"users/error"
        end
    end

    delete '/list/:id' do
        if is_logged_in? && current_user
            session[:user_id] = current_user.id 
            @item = Item.find_by(id: params[:id])  
            @item.delete
            redirect to "/view"
        else
            erb :"users/error"
        end
    end
end

