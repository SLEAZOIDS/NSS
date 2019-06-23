Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  get "home", to: "home#index", as: "user_root"
  
  get 'books/google'
  get 'books/rakuten'
  get 'users/redis'
end
