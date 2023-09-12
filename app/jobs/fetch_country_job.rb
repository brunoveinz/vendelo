class FetchCountryJob < ApplicationJob
  queue_as :default

  def perform(user_id, ip)
    country = FetchCountryService.new(ip).perform
    user = User.find(user_id)
    if country
      user.update(country: country)
    end
  end
end


# los jobs son tareas que se ejecutan en segundo plano 
# generalmente se utilizan para tareas pesadas que no sabemos cuanto demoraran
# y cunado solicitamos informacion a 3eros


# a los background jobs no se le pasan objetos porque es dificil serializar
#en la base de datos se le pasan referencias y luego hacemos la peticion a la bbdd