require 'rubygems'
require 'bundler/setup'

require 'open-uri'
require 'nokogiri'
require 'json'

Dir.mkdir('kml') unless File.exists?('kml')

File.open('bus-services.json', 'r') do |bus_services_json|
  bus_services = JSON(bus_services_json.read)
  bus_services.each do |bus_service|
    bus_service['buses'].each do |bus|
      number = bus['number']
      direction = bus['direction']
      bus_stops = JSON(File.open("bus-stops/#{number}.json", 'r').read)
      direction.times do |i|
        bus_routes = Nokogiri::XML(open("bus-routes/#{number}-#{i+1}.kml"),&:noblanks)
        folder = bus_routes.xpath('/ns0:kml/ns0:Document/ns0:Folder', 'ns0' => 'http://earth.google.com/kml/2.2')[0]
        folder = bus_routes.xpath('/ns0:kml/ns0:Document', 'ns0' => 'http://earth.google.com/kml/2.2')[0] if folder.nil?
        if folder.nil? then
          puts "ERROR > Fails to find an insertion point for placemarks for bus #{number} (#{i+1})"
          next
        end
        bus_stops['direction'][i].each do |bus_stop|
          placemark = Nokogiri::XML::Node.new('Placemark', bus_routes)
		  name = Nokogiri::XML::Node.new('name', bus_routes)
		  name.content = bus_stop['code']
		  placemark.add_child(name)
		  description = Nokogiri::XML::Node.new('description', bus_routes)
		  description.content = bus_stop['name']
		  placemark.add_child(description)
		  point = Nokogiri::XML::Node.new('Point', bus_routes)
		  coordinates = Nokogiri::XML::Node.new('coordinates', bus_routes)
		  coordinates.content = "#{bus_stop['latlng']},0"
		  point.add_child(coordinates)
		  placemark.add_child(point)
		  folder.add_child(placemark)
        end
        File.open("kml/#{number}-#{i+1}.kml", 'w') do |f|
		  f.write bus_routes.to_xml(:indent => 2, :encoding => 'UTF-8')
	    end
      end
    end
  end
end