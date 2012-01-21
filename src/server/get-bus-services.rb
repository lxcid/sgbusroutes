require "rubygems"
require "bundler/setup"

require "open-uri"
require "nokogiri"

Nokogiri::HTML(open("http://publictransport.sg/content/publictransport/en/homepage/map.html")).css("select#busservice_option optgroup").each do |optgroup|
  puts "Type: #{optgroup[:label]}"
  optgroup.css("option").each do |option|
    bus_number = option.inner_text
    split_values = option[:value].split("_")
    if (split_values.nil? || split_values.count != 2)
      puts "\tERROR > Bus #{bus_number}'s direction could not be parsed.\n #{option[:value]}"
      next
    end
    direction = split_values[1]
    puts "\tBus: #{bus_number} (#{direction})"
  end
end
