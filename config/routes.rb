Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'welcome/home', to: 'welcome#home'
  get 'welcome/about', to: 'welcome#about'
  get 'about', to: 'pages#about'
end
