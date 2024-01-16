Rails.application.routes.draw do
  devise_for :users
  root "articles#index"

  #Esto crea comentarios como un recurso anidado dentro de los artículos. Esta es otra parte de capturar la relación jerárquica que
  # existe entre artículos y comentarios.
  resources :articles do
    resources :comments
  end

end
