require 'rubygems'
require 'bundler/setup'

require 'open-uri'
require 'nokogiri'
require 'json'

Dir.mkdir('bus-stops') unless File.exists?('bus-stops')

File.open('bus-services.json', 'r') do |bus_services_json|
  bus_services = JSON(bus_services_json.read)
  bus_services.each do |bus_service|
    bus_service['buses'].each do |bus|
      number = bus['number']
      direction = bus['direction']
      bus = {}
      bus['number'] = number
      case direction
      when 1
        html = open("http://publictransport.sg/content/publictransport/en/homepage/Ajax/map_ajaxlib.getBusRouteByServiceId.#{number}.html")
        bus_stops = []
        Nokogiri::HTML(html).xpath("//div[@class='bus_stop_code']").each do |bus_stop_code|
          next if bus_stop_code.xpath("./a")[0].nil?
          code = bus_stop_code.xpath("./a")[0].inner_text
          name = bus_stop_code.xpath("./following-sibling::*")[0].inner_text
          latlng = bus_stop_code.attributes['onclick'].to_s.gsub(/showOnMapWithBusRoute\(|\)/, '')
          bus_stops << { 'name' => name, 'code' => code, 'latlng' => latlng }
        end
        bus['direction'] = [bus_stops]
      when 2
        html = open("http://publictransport.sg/content/publictransport/en/homepage/Ajax/map_ajaxlib.getBusRouteByServiceId.#{number}.html")
        bus_stops_1 = []
        Nokogiri::HTML(html).xpath("//div[@class='bus_stop_code' and position() mod 2 = 0]").each do |bus_stop_code|
          next if bus_stop_code.xpath("./a")[0].nil?
          code = bus_stop_code.xpath("./a")[0].inner_text
          name = bus_stop_code.xpath("./following-sibling::*")[0].inner_text
          latlng = bus_stop_code.attributes['onclick'].to_s.gsub(/showOnMapWithBusRoute\(|\)/, '')
          bus_stops_1 << { 'name' => name, 'code' => code, 'latlng' => latlng }
        end
        html = open("http://publictransport.sg/content/publictransport/en/homepage/Ajax/map_ajaxlib.getBusRouteByServiceId.#{number}.html")
        bus_stops_2 = []
        Nokogiri::HTML(html).xpath("//div[@class='bus_stop_code' and position() mod 2 = 1]").each do |bus_stop_code|
          next if bus_stop_code.xpath("./a")[0].nil?
          code = bus_stop_code.xpath("./a")[0].inner_text
          name = bus_stop_code.xpath("./following-sibling::*")[0].inner_text
          latlng = bus_stop_code.attributes['onclick'].to_s.gsub(/showOnMapWithBusRoute\(|\)/, '')
          bus_stops_2 << { 'name' => name, 'code' => code, 'latlng' => latlng }
        end
        bus['direction'] = [bus_stops_1, bus_stops_2]
      else
        puts "Error > Unsupported number of direction(s): #{direction}"
      end
      File.open("bus-stops/#{number}.json", 'w') do |f|
        f.puts JSON.pretty_generate(bus)
      end
    end
  end
end