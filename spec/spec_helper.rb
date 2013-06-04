require 'rspec'
require 'cssquirt'
include CSSquirt

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end
