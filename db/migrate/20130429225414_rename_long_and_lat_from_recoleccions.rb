class RenameLongAndLatFromRecoleccions < ActiveRecord::Migration
  change_table :recoleccions do |t|
    t.rename :long, :longitude
    t.rename :lat, :latitude
  end
end
