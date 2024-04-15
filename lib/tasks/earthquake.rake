namespace :earthquake do
  desc "TODO"
  task get_data: :environment do
    require 'rest-client'
    response = RestClient.get(ENV['EARTHQUAKE_API_URL'])

    results = JSON.parse(response.to_str)
    results["features"].each do |f|

      isValidMagnitude =  f["properties"]["mag"].to_d.between?(-1.0,10.0)
      isValidLatitude =  f["geometry"]["coordinates"][0].to_d.between?(-90.0,90.0)
      isValidLongitude =  f["geometry"]["coordinates"][1].to_d.between?(-180.0,180.0)
      
      if isValidLatitude && isValidLongitude && isValidMagnitude
          feature = Feature.new(
          external_id: f["id"], 
          magnitude: f["properties"]["mag"], 
          place: f["properties"]["place"], 
          time: f["properties"]["time"], 
          tsunami: f["properties"]["tsunami"], 
          mag_type: f["properties"]["magType"], 
          title: f["properties"]["title"], 
          longitude: f["geometry"]["coordinates"][0], 
          latitude: f["geometry"]["coordinates"][1], 
          external_url: f["properties"]["url"]
        )
        begin
          feature.save
        rescue ActiveRecord::RecordNotUnique
          puts "The register with external_id #{f["id"]} already exists. Skiping..."
        end
      end
    end
  end
end
