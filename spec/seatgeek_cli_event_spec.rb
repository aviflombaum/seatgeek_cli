require 'spec_helper'

describe SeatgeekCLI::Event do
  let(:event){SeatgeekCLI::Event.new}

  context 'properties' do
    it 'has a title' do
      event.title = "Event Title"
      expect(event.title).to eq("Event Title")
    end
    it 'has a url' do
      event.url = "Event URL"
      expect(event.url).to eq("Event URL")
    end
    it 'has a local_time' do
      event.local_time = "Event Local Time"
      expect(event.local_time).to eq("Event Local Time")
    end
    it 'has a venue_name' do
      event.venue_name = "Event Venue Name"
      expect(event.venue_name).to eq("Event Venue Name")
    end
    it 'has a venue_address' do
      event.venue_address = "Event Venue Address"
      expect(event.venue_address).to eq("Event Venue Address")
    end
    it 'has a venue_city' do
      event.venue_city = "Event Venue City"
      expect(event.venue_city).to eq("Event Venue City")
    end
    it 'has a venue_state' do
      event.venue_state = "Event Venue State"
      expect(event.venue_state).to eq("Event Venue State")
    end
    it 'has a venue_url' do
      event.venue_url = "Event Venue URL"
      expect(event.venue_url).to eq("Event Venue URL")
    end
  end

  describe '#save' do
    it 'saves the event into all events' do
      event.save

      expect(SeatgeekCLI::Event.all).to include(event)
    end
  end

  describe '.all' do
    it 'returns all my event instances' do
      event.save

      expect(SeatgeekCLI::Event.all).to include(event)
    end
  end

  describe '.reset_all!' do
    it 'resets all the events' do
      event.save

      SeatgeekCLI::Event.reset_all!
      expect(SeatgeekCLI::Event.all).to be_empty
    end
  end

end
