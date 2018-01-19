Rails.application.routes.draw do

  resources :group_events, only: [:create, :destroy, :update] do
    put :publish, on: :member
  end
end
