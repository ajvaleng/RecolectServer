class AddDatetimeToRecolecions < ActiveRecord::Migration
  def change
    add_column :recoleccions, :llegada_paradero, :datetime
    add_column :recoleccions, :salida_paradero, :datetime
  end
end
