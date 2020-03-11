class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  def create
    @micropost = Micropost.find(params[:micropost_id])
    #current_user.fav(micropost)
    @micropost.fav(current_user)
    flash[:success] = 'いいねしました'
    redirect_back(fallback_location: root_path)
    # redirect_to :back
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    #current_user.unfav(micropost)
    @micropost.unfav(current_user)
    flash[:success] = 'いいねをとりけしました'
    redirect_back(fallback_location: root_path)#ページ移行させさない
    # redirect_to @micropost.user
  end
end
