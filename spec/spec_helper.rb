$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'seatgeek_cli'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
end
