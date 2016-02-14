class SeatgeekCLI::Event # Model
  attr_accessor :title,
                :url,
                :local_time,
                :venue_name,
                :venue_address,
                :venue_city,
                :venue_state,
                :venue_url
  @@all = []
    
  def local_time_to_s
    @local_time.strftime("%A %B %d %I:%M")
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.reset_all!
    @@all.clear
  end
end
