Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        collection do
          post 'login'
          post 'logout'
          get 'confirm_login'
          post 'facebook_token'
        end
      end
      
      resources :contacts do
        
      end
    end
  end
end
