Rails.application.routes.draw do
  get 'sessions/new'

  get 'signup'  => 'users#new'

  get 'index'   => 'users#index'

  get 'help'  => 'static_pages#help'

  get 'about' => 'static_pages#about'

  get 'home'  => 'static_pages#home'

  get 'contact' =>  'static_pages#contact'

  get 'login' => 'sessions#new'

  post 'login'	=> 'sessions#create'

  root 'static_pages#home'

  delete 'logout'	=> 'sessions#destroy'

  resources :users do
    member do
      get :following, :followers
    end
  end

  # => member method works with user_id   => /users/1/following || /users/1/followers
  #
  # => collection method works without user_id => /users/following
  #

  resources :account_activations, only: [ :edit ]

  resources :password_resets, only: [ :create, :edit, :new, :update ]

  resources :microposts, only: [ :create, :destroy ]

  resources :relationships, only: [ :create, :destroy ]

  resources :likes, only: [ :create, :destroy ]
  
end
