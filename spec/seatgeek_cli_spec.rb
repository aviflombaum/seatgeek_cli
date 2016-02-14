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

    describe '#call' do
      it 'Welcomes the user to Seatgeek upon call' do
        VCR.use_cassette("seatgeek-user-location") do
          expect{cli.call}.to output("Welcome to Seatgeek you geek!\nYou are in: New York, NY\n").to_stdout
        end
      end
    end

    describe '#user_location' do
      it 'returns the user location based on the Seatgeek Geolocation Data' do
        VCR.use_cassette("seatgeek-user-location") do
          expect(cli.user_location).to eq("New York, NY")
        end
      end
    end

    describe '#list_concerts' do
    end
  end
end
