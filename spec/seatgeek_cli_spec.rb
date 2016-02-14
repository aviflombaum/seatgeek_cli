require 'spec_helper'

describe SeatgeekCLI do
  it 'has a version number' do
    expect(SeatgeekCLI::VERSION).not_to be nil
  end

  context SeatgeekCLI::CLI do
    describe '#initialize' do
      it 'accepts an IP address for the user' do
        cli = SeatgeekCLI::CLI.new('108.41.19.28')

        expect(cli.external_ip).to eq('108.41.19.28')
      end

      it 'finds the external ip address of the user' do
        expect(SeatgeekCLI::CLI).to receive(:get_external_ip).and_return('108.41.19.28')

        cli = SeatgeekCLI::CLI.new
        expect(cli.external_ip).to eq('108.41.19.28')
      end
    end

    describe '#call' do
      let(:cli){SeatgeekCLI::CLI.new("108.41.19.28")}
      
      it 'Welcomes the user to Seatgeek upon call' do
        expect{cli.call}.to output("Welcome to Seatgeek you geek!\n").to_stdout
      end
    end
  end
end
