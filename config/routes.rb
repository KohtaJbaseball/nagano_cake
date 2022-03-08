Rails.application.routes.draw do

  namespace :public do
    get 'cart_items/index'
  end
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  scope module: :public do
    root to: 'homes#top'

    get '/about' => 'homes#about'

    get '/customers/my_page' => 'customers#show'
    get '/customers/edit'
    get '/customers/quit'

    get '/cart_items' => 'cart_items#index'
    patch '/cart_items/:id' => 'cart_items#update', as: 'update_cart_item'
    delete '/cart_items/:id' => 'cart_items#destroy', as: 'destroy_cart_item'
    delete '/cart_items/destroy_all' => 'cart_items#destroy', as: 'destroy_all_cart_item'
    post '/cart_items' => 'cart_items#create'
    resources :address, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  namespace :admin do
    resources :genres, only: [:index, :edit, :create, :update]
    resources :items, only: [:index, :new, :show, :edit, :create, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    get '/' => "homes#top"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
