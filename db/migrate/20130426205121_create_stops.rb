class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.string :stopid
      t.string :stopdcode
      t.string :stopname
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
