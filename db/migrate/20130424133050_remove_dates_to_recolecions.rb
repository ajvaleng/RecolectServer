class RemoveDatesToRecolecions < ActiveRecord::Migration
  def up
    remove_column :recoleccions, :llegada_paradero
    remove_column :recoleccions, :salida_paradero
  end

  def down
    add_column :recoleccions, :llegada_paradero, :string
    add_column :recoleccions, :salida_paradero, :string
  end
end
