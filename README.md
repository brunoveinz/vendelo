M => consultas validaciones, relaciones bbdd
V => Devolver al usuario html, pdf, csv, json
C => logica


shared 
los parcial son porciones de codigo que se reutilizaran

comienzan por convencion _nombre
y cuando los queremos renderizar es <% render 'ruta'+nombre sin _>


Raills nos permite hacer test para comprobar que todo funcione bien 
en test y en fixture esta nuestra "base de datos de prueba"


// rutas
  # tipo de peticion / ruta to = metodo#Acciones  == index cuando devolvemos muchas cosas
  delete '/products/:id', to: 'products#destroy'
  patch '/products/:id', to: 'products#update' 
  post '/products', to: 'products#create'
  get '/products', to: 'products#index'
  get '/products/new', to: 'products#new' , as: :new_product
  get '/products/:id', to: 'products#show', as: :product
  get '/products/:id/edit', to: 'products#edit', as: :edit_product