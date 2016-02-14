class SeatgeekCLI::CLI
  attr_reader :external_ip

  def initialize(external_ip = nil)
    @external_ip = external_ip || self.class.get_external_ip
  end

  def call
    puts "Welcome to Seatgeek you geek!"
  end

  def self.get_external_ip
    `curl https://api.ipify.org`
  end
end
