Rails.application.routes.draw do
  resource :signup, only: %i[create]
  resources :authentications, only: %i[create]
  resources :users, only: %i[index delete] do
    patch 'archive'
    patch 'unarchive'
    get 'changes'
  end
end
