ActiveAdmin.register Recoleccion do
  scope :sin_ubicacion 
  
  index do 
    column :llegada_paradero
    column :salida_paradero
    column :presonas_suben
    column :personas_bajan
    column :recorrido
    column :patente
    column :nombre
    column :puerta
    column :periodo    
  end
  
    filter :llegada_paradero
    filter :salida_paradero
    filter :recorrido
    filter :patente
    filter :nombre
    filter :puerta
    filter :periodo
end
