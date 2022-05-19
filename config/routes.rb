Rails.application.routes.draw do

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  root to: "public/homes#top"
  get "public/homes/about"

  scope module: :public do
    resource :customers, only: [] do
      get "my_page" => "customers#show"
      get "my_page/edit" => "customers#edit"
      patch "my_page/update" => "customers#update"
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
  end

  namespace :admin do
    get "homes/top"

    resources :customers, only: [:index, :show, :edit, :update]

    resources :items, exepect: [:destroy]

    resources :genres, only: [:index, :create, :edit, :update]

    resources :orders, only: [:index, :show, :update]

    resources :order_details, only: [:update]
  end
end