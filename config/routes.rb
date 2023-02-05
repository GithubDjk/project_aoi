Rails.application.routes.draw do
  resources :contents
  namespace :api do
    namespace :v1 do
      resources :auth, only: [] do
        collection do
          post 'signin'
          post 'signup'
        end
      end
      get 'projects/my_projects', to: 'projects#my_projects'
      resources :projects, except: [:patch] do
        resources :contents
      end
    end
  end
end
