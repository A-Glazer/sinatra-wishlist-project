class ListController < ApplicationController

    get '/view/:id' do
        @user = User.find_by_id(session[:user_id])
        # binding.pry
            if is_logged_in?
            erb :"/list/view"
            else
                erb :"users/error"
            end
       
    end


end

