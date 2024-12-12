# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require_relative '../app/services/sneaker_api_service'

puts "Fetching sneakers for Yeezys..."
sneakers_data = SneakerApiService.fetch_sneakers("yeezy", "yeezy", 40) # Fetch 40 sneakers per query

sneakers_data.each do |sneaker|
  begin
    Product.create!(
      name: sneaker["shoeName"], # Adjust key to match actual response
      description: sneaker["description"] || "No description available",
      price: sneaker["price"].to_f, # Ensure price is a float
      stock_quantity: rand(10..50), # Random stock quantity
      image_url: sneaker["thumbnail"] # Replace key with actual image URL
    )
    puts "Seeded: #{sneaker['name']}"
  rescue StandardError => e
    puts "Failed to save sneaker #{sneaker['name']}: #{e.message}"
  end
end


puts "All sneakers seeded successfully!"