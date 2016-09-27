Rails.application.routes.draw do
  resources :messages, :only => [:index, :new, :create, :show]

  resources :contacts do
    resources :messages, :only => [:new, :create]
  end
end
