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
end
