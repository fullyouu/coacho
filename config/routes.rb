Rails.application.routes.draw do
  devise_for :users do
    resources :appointments, only: %i[index]
  end
  root to: 'pages#home'
  get '/dashboard', to: 'dashboard#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :offers do
    resources :appointments, only: %i[create update delete]
  end
end
