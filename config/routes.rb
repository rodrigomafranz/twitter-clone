Rails.application.routes.draw do
  resources :messages, except: %i[index show] do 
    post 'retweet', to: 'messages#retweet'
  end

  get  'login',  to: 'sessions#new'
  post 'login',  to: 'sessions#create'
  get  'logout', to: 'sessions#destroy'
  
  get  'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get    '@:name',          to: 'users#show',    as: :user
  post   '@:name/follow',   to: 'users#follow',   as: :follow_user
  delete '@:name/unfollow', to: 'users#unfollow', as: :unfollow_user

  root 'timeline#index'
end