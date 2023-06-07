Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :categories
  resources :merchants
  resources :transactions do
    collection do
      put 'update_transactions'
    end
  end
end
