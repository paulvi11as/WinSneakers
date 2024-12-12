require 'net/http'
require 'uri'
require 'json'

class SneakerApiService
  API_HOST = 'sneaker-database-stockx.p.rapidapi.com'
  API_KEY = 'f66e869089mshecc767dd4dec2cbp12890cjsn703bfe325b6f'

  def self.fetch_sneakers(query, market, limit = 50)
    url = URI("https://#{API_HOST}/stockx/sneakers?query=#{query}&market=#{market}&limit=#{limit}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = API_KEY
    request["x-rapidapi-host"] = API_HOST

    response = http.request(request)

    # Print the raw response for debugging
    puts "Raw Response: #{response.body}"

    # Parse the JSON response
    JSON.parse(response.body)
  end
end
