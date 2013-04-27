class ChangeLatLongToRecolecions < ActiveRecord::Migration
  def change
      rename_column :recoleccions, :lat, :latitude
      rename_column :recoleccions, :long, :longitude
  end
end
