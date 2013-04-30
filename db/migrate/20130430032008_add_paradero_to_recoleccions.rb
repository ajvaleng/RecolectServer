class AddParaderoToRecoleccions < ActiveRecord::Migration
  def change
    add_column :recoleccions, :paradero, :string
  end
end
