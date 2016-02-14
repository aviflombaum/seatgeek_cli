require 'spec_helper'

describe SeatgeekCLI do
  it 'has a version number' do
    expect(SeatgeekCLI::VERSION).not_to be nil
  end

  context SeatgeekCLI::CLI do
    let(:cli){SeatgeekCLI::CLI.new("108.41.19.28")}

    describe '#initialize' do
      it 'accepts an IP address for the user' do
        expect(cli.external_ip).to eq('108.41.19.28')
      end

      it 'finds the external ip address of the user' do
        expect(SeatgeekCLI::CLI).to receive(:get_external_ip).and_return('108.41.19.28')

        cli = SeatgeekCLI::CLI.new
        expect(cli.external_ip).to eq('108.41.19.28')
      end
    end

    describe '#greet_user' do
      it 'Welcomes the user to Seatgeek upon call' do
        expect{cli.greet_user}.to output("Welcome to Seatgeek you geek!\n").to_stdout
      end
    end

    describe '#print_location' do
      it 'prints the location of the user from seatgeek' do
        expect{cli.print_location}.to output("You are in: New York, NY\n").to_stdout
      end
    end

    describe '#user_location' do
      it 'returns the user location based on the Seatgeek Geolocation Data' do
        expect(cli.user_location).to eq("New York, NY")
      end
    end

    describe '#list_events' do
      it 'prints out all the event titles' do
        expect{
          cli #=> trigger the events to load
          SeatgeekCLI::Event.reset_all!

          # Creating some known data.
          event_1 = SeatgeekCLI::Event.new
          event_1.title = "Event 1"
          event_1.save

          event_2 = SeatgeekCLI::Event.new
          event_2.title = "Event 2"
          event_2.save

          cli.list_events
        }.to output("Events near you:\n1. Event 1\n2. Event 2\n").to_stdout
      end
    end
  end
end
