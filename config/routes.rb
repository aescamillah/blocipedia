Rails.application.routes.draw do

  get 'charges/new'

resources :wikis
resources :charges, only: [:new, :create]

  devise_for :users, controllers: { registrations: "users/registrations"}

  devise_scope :user do
    post 'users/downgrade' => 'users/registrations#downgrade', as: :downgrade
  end


  # post 'users/upgrade' => 'users/registrations#upgrade', as: :upgrade

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
