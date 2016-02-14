class SeatgeekCLI::CLI
  attr_reader :external_ip

  def initialize(external_ip = nil)
    @external_ip = external_ip || self.class.get_external_ip
    @wrapper = SeatgeekCLI::Wrapper.new(@external_ip)
    @wrapper.load_events #=> At the end of this evocation, Event.all should exist
  end

  def call
    greet_user
    print_location
    list_events
    menu
  end

  def help
    puts "What would you like to do?"
    puts "Either type `list` to list the events again or type an event number for more information"
  end

  def menu
    help
    input = gets.strip
    while input != "exit"
      if input == "list"
        list_events
      else
        if event = SeatgeekCLI::Event.all[input.to_i-1]
          print_details(event)
        else
          puts "Can't find an event, try numbers between 1-#{SeatgeekCLI::Event.all.size}"
        end
      end
      help
      input = gets.strip
    end
    puts "Goodbye"
  end

  def print_details(event)
    puts "#{event.title}"
    puts "#{event.url}"
    puts "#{event.local_time_to_s}"
    puts "#{event.venue_name}"
    puts "#{event.venue_address}"
    puts "#{event.venue_city}"
    puts "#{event.venue_state}"
    puts "#{event.venue_url}"
  end

  def print_location
    puts "You are in: #{user_location}"
  end

  def greet_user
    puts "Welcome to Seatgeek you geek!"
  end

  def list_events
    puts "Events near you:"
    SeatgeekCLI::Event.all.each.with_index(1) do |event, i|
      puts "#{i}. #{event.title}"
    end
  end

  def user_location
    @wrapper.user_location
  end

  def self.get_external_ip
    `curl https://api.ipify.org --silent`
  end
end
