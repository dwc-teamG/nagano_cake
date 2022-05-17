Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  root to: "public/homes#top"
  get "public/homes/about"

  resources :customers, only: [:show, :edit, :update] do
    get "unsubscribe" => "customers#unsubscribe"
    patch "withdraw" => "customers#withdraw"
  end

  resources :addresses, only: [:index, :edit, :create, :update, :destroy]

  resources :items, only: [:index, :show]

  resources :cart_items, only: [:index, :update, :destroy, :create] do
    delete "destroy_all" => "cart_items#destroy_all"
  end

  resources :orders, only: [:new, :create, :index, :show] do
    post "confirm" => "orders#confirm"
    get "complete" => "orders#complete"
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get "homes/top"

    resources :customers, only: [:index, :show, :edit, :update]

    resources :items

    resources :genres, only: [:index, :create, :edit, :update]

    resources :orders, only: [:show, :update]

    resources :order_details, only: [:update]
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
