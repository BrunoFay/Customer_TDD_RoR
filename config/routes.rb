Rails.application.routes.draw do
  resources 'customers'
  get 'welcome/index'
  root 'welcome#index'
end
