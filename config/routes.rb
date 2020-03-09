Rails.application.routes.draw do
    root to: 'toppages#index'
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'signup', to: 'users#new'
    resources :users, only: [:index, :show, :new, :create] do
        member do
            get :followings #フォローしてる人
            get :followers  #フォロワー
        end
        # collection do
        #     get :search
        # end
    end
    
    resources :microposts, only: [:create, :destroy]
    resources :relationships, only: [:create, :destroy] #フォロー、アンフォロー
    
end
