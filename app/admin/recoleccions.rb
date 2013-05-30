ActiveAdmin.register Recoleccion do
  #scope :sin_ubicacion 
  
  index do 
    column "Llegada",:llegada_paradero
    column "Salida",:salida_paradero
    column "Suben",:presonas_suben
    column "Bajan",:personas_bajan
    column "Linea",:recorrido
    column :paradero
    column :patente
    column :nombre
    column :puerta

    default_actions 
  end
  
    filter :llegada_paradero
    filter :salida_paradero
    filter :recorrido
    filter :patente
    filter :nombre
    filter :puerta
end
