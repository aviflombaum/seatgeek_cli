class SeatgeekCLI::Wrapper

  def initialize(external_ip)
    @external_ip = external_ip
  end

  def data
    unless @data
      url = "https://api.seatgeek.com/2/events?geoip=#{@external_ip}"
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)
      @data = response.body
    else
      @data
    end
  end

  def user_location
    @user_location = json["meta"]["geolocation"]["display_name"]
  end

  def json
    @json ||= JSON.parse(data)
  end

  def events_data
    json["events"]
  end

  def load_events
    events_data.each do |event_hash|
      e = SeatgeekCLI::Event.new
      e.title = event_hash["title"]
      e.url = event_hash["url"]
      e.local_time = DateTime.parse(event_hash['datetime_local'])
      e.venue_name = event_hash["venue"]["name"]
      e.venue_address = event_hash["venue"]["address"]
      e.venue_city = event_hash["venue"]["city"]
      e.venue_state = event_hash["venue"]["state"]
      e.venue_url = event_hash["venue"]["url"]

      e.save
    end
  end

end
