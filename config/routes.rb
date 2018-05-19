Rails.application.routes.draw do
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'
  devise_for :users, skip: [:sessions, :registrations, :passwords]
  devise_scope :user do
    post "/sign_in", to: 'sessions#create'
    post "/sign_up" => 'registrations#create'
    delete "/sign_out", to: 'sessions#destroy'
  end
end
