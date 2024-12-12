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

# Fetch sneakers for popular queries
queries = ["Adidas", "Nike", "Puma", "Converse", "Jordan"]

queries.each do |brand_query|
  puts "Fetching sneakers for #{brand_query}..."
  sneakers_data = SneakerApiService.fetch_sneakers(brand_query)

  # Navigate to results array within the API response
  results = sneakers_data.dig("data", "results") || []

  results.each do |sneaker|
    # Skip entries with null or blank names
    next if sneaker["name"].blank?

    begin
      # Use the 'model' field to create or find the category
      category_name = sneaker["model"] || "Unknown"
      category = Category.find_or_create_by!(name: category_name)

      # Create the product
      product = Product.create!(
        name: sneaker["title"],
        description: sneaker["description"] || "No description available",
        price: rand(50..300), # Generate a random price
        stock_quantity: rand(10..100), # Generate a random stock quantity
        category: category
      )

      # Add images to the product
      image_urls = [sneaker.dig("media", "smallImageUrl"), sneaker.dig("media", "thumbUrl")].compact
      image_urls.each do |image_url|
        ProductImage.create!(
          product: product,
          image_url: image_url
        )
      end

      puts "Seeded: #{sneaker['title']} with #{image_urls.size} images"
    rescue StandardError => e
      puts "Failed to save sneaker #{sneaker['title']}: #{e.message}"
    end
  end
end

puts "All sneakers seeded successfully!"

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?