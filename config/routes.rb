Rails.application.routes.draw do
  get 'homes/top'
  root to: "homes#top"
  devise_for :users, controllers: {
  sessions: 'users/sessions'
}
  get 'home/about' => 'homes#about', as: "about"
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :index, :update, :destroy] do
  resources :books, only: [:index], controller: 'books'
  end
  end
