Rails.application.routes.draw do

  devise_for :users
  resource :user

  resources :events

  namespace :admin do
    root "events#index"
    resources :events do
      collection do
        post :bulk_update
      end

      member do
       post :reorder
     end
     
    end
    resources :users
  end

  root "events#index"

end
