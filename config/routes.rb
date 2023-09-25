Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'posts/store' => 'posts#store'
  get 'posts/food' => 'posts#food'
  get 'posts/animal' => 'posts#animal'
  
  resources :posts do
    resources :likes, only: [:create, :destroy]
  end

  root 'posts#top'
  
end
