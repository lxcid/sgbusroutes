require 'rubygems'
require 'bundler/setup'

require 'open-uri'
#require 'nokogiri'
require 'json'

Dir.mkdir('bus-routes') unless File.exists?('bus-routes')

File.open('bus-services.json', 'r') do |bus_services_json|
  bus_services = JSON(bus_services_json.read)
  bus_services.each do |bus_service|
    bus_service['buses'].each do |bus|
      number = bus['number']
      direction = bus['direction']
      1.upto(direction) do |i|
        filename = "#{number}-#{i}.kml"
        #puts filename
        open("bus-routes/#{filename}", 'w') do |f|
          f << open("http://publictransport.sg/kml/busroutes/#{filename}").read
        end
      end
    end
  end
end