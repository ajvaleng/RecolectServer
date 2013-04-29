namespace :db do

  desc "load user data from csv"
  task :load_csv_data  => :environment do
    require 'fastercsv'

    CSV.foreach("stops1.csv") do |row|
      Stop.create(
        :stopid => row[0],
        :stopcode=> row[1],
        :stopname=> row[2],
        :latitude=> row[3],
        :logitude=> row[4]
      )
    end
  end
end
