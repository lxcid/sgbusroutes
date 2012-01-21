require "rubygems"
require "bundler/setup"

require "open-uri"
require "nokogiri"

Nokogiri::HTML(open("http://publictransport.sg/content/publictransport/en/homepage/map.html")).css("select#busservice_option optgroup").each do |optgroup|
  puts "Type: #{optgroup[:label]}"
  optgroup.css("option").each do |option|
    bus_number = option.inner_text
    direction = option[:value].split("_")[1]
    puts "\tBus: #{bus_number} (#{direction})"
  end
end
