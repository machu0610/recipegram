Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :users #必要なルーティングが全て作成される。
  resources :recipes
end
