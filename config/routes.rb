Rails.application.routes.draw do
 get '/customers/edit' => 'public/customers#edit'
 patch '/customers' => 'public/customers#update', as: 'update_customer'
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'

    get '/customers/my_page' => 'customers#show'
    get '/customers/edit' => 'customers#edit', as: 'edit_customer'
    get '/customers/quit'
    patch '/customers/out' => 'customers#out'

    get '/cart_items' => 'cart_items#index'
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all_cart_item'
    patch '/cart_items/:id' => 'cart_items#update', as: 'update_cart_item'
    delete '/cart_items/:id' => 'cart_items#destroy', as: 'destroy_cart_item'
    post '/cart_items' => 'cart_items#create'

    resources :address, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]

    get '/orders/thanks' => 'orders#thanks'
    post '/orders/confirm' => 'orders#confirm'
    resources :orders, only: [:new, :index, :show, :create]
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  namespace :admin do
    get '/' => "homes#top"
    resources :genres, only: [:index, :edit, :create, :update]
    resources :items, only: [:index, :new, :show, :edit, :create, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
