Rails.application.routes.draw do

  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

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
