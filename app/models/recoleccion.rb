class Recoleccion < ActiveRecord::Base
  attr_accessible :latitude, :llegada_paradero, :longitude, :nombre, :patente, :periodo, :personas_bajan, :presonas_suben, :puerta, :recorrido, :salida_paradero

  scope :sin_ubicacion, where(:lat => nil)
  
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

end
