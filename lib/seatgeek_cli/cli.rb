class SeatgeekCLI::CLI
  attr_reader :external_ip

  def initialize(external_ip = nil)
    @external_ip = external_ip || self.class.get_external_ip
  end

  def call
    puts "Welcome to Seatgeek you geek!"
    puts "You are in: #{user_location}"
  end

  def user_location
    # How do we get the user's location from seatgeek
    url = "https://api.seatgeek.com/2/events?geoip=#{external_ip}"
    # Open this URL
    # parse this into json
    # json = {
    #   meta: {
    #     per_page: 10,
    #     total: 65,
    #     page: 1,
    #     geolocation: {
    #     city: "Rockford",
    #     display_name: "Rockford, IL",
    #     country: "US",
    #     lon: -89.0816,
    #     range: "12mi",
    #     state: "IL",
    #     postal_code: "61103",
    #     lat: 42.3423
    #   }
    # }
    # json[:meta][:geolocation][:display_name] #=> "New York, NY"


    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    data = response.body
    json = JSON.parse(data)
    @user_location = json["meta"]["geolocation"]["display_name"]
  end

  def self.get_external_ip
    `curl https://api.ipify.org --silent`
  end
end
