class ListController < ApplicationController

    get "/view" do
        if is_logged_in? #&& item.user_id == current_user.id
                # session[:user_id] = current_user.id       
                @items = current_user.items
                erb :"/list/view"
            else
                erb :"users/error"
            end
    end

    get '/new' do
        if is_logged_in? #&& item.user_id == current_user.id
            # session[:user_id] = current_user.id
                erb :"/list/new"
            else
                erb :"users/error"
            end
    end

    post '/items' do
        if is_logged_in? && !params[:name].empty? && !params[:quantity].empty? #&& item.user_id == current_user.id 
            # session[:user_id] = current_user.id       
            @item = Item.create(name: params[:name], quantity: params[:quantity])
            current_user.items << @item
            redirect to "/view"
        else
            redirect to "/new"
        end
    end

    get '/list/:id/edit' do
        @item = Item.find_by(id: params[:id])
        if is_logged_in? && @item.user_id == current_user.id 
        # session[:user_id] = current_user.id                   
            erb :"list/edit"
        else
            erb :"users/error"
        end
    end

    patch '/list/:id' do
        @item = Item.find_by(id: params[:id])
        if is_logged_in? && @item.user_id == current_user.id && !params[:name].empty? && !params[:quantity].empty?
            @item.update(name: params[:name], quantity: params[:quantity])
            redirect to "/view"
        else
            erb :"users/error"
        end
    end

    delete '/list/:id' do
        @item = Item.find_by(id: params[:id])  
        if is_logged_in? && @item.user_id == current_user.id
            # session[:user_id] = current_user.id  
            @item.delete
            redirect to "/view"
        else
            erb :"users/error"
        end
    end
end

