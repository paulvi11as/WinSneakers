require 'net/http'
require 'uri'
require 'json'

class SneakerApiService
  API_HOST = 'sneaker-database-stockx.p.rapidapi.com'
  API_KEY = 'f66e869089mshecc767dd4dec2cbp12890cjsn703bfe325b6f'

  def self.fetch_sneakers(query)
    url = URI("https://#{API_HOST}/stockx/sneakers?query=#{query}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = API_KEY
    request["x-rapidapi-host"] = API_HOST

    response = http.request(request)
    data = JSON.parse(response.body)

    # Filter out entries with null or blank names
    filtered_results = (data.dig("data", "results") || []).reject { |sneaker| sneaker["name"].blank? }

    puts "Filtered Results Count: #{filtered_results.size}"
    { "data" => { "results" => filtered_results } }
  rescue StandardError => e
    puts "Error fetching sneakers: #{e.message}"
    { "data" => { "results" => [] } }
  end
end