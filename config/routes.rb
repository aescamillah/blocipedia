Rails.application.routes.draw do

  root to: 'welcome#index'
  get 'charges/new'
  get 'about' => 'welcome#about'
  resources :wikis
  resources :charges, only: [:new, :create]
  devise_for :users, controllers: { registrations: "users/registrations"}
  devise_scope :user do
    post 'users/downgrade' => 'users/registrations#downgrade', as: :downgrade
  end

end
