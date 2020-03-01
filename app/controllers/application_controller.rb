class ApplicationController < ActionController::Base

    include SessionsHelper
    
    private
    def require_user_logged_in
        unless logged_in?   #ifの反対　if => false の時
            redirect_to login_url
        end
    end
end
