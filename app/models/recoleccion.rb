class Recoleccion < ActiveRecord::Base
  attr_accessible :latitude, :llegada_paradero, :longitude, :nombre, :patente, 
  :periodo, :personas_bajan, :presonas_suben, :puerta, :recorrido, :salida_paradero, :paradero

  scope :sin_ubicacion, where(:lat => nil)
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end
  
  def self.cmp_wday (dias, fecha)
    semana = ["","Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","Domingo"]
    dias.include? (semana[fecha.wday])
  end

end
