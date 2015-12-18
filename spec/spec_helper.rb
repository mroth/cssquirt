require 'rspec'
require 'cssquirt'
include CSSquirt

RSpec.configure do |config|
  config.color         = true
  config.formatter     = 'documentation'

  config.before(:all) { silence_output }
  config.after(:all)  { enable_output }
end


# Redirects stderr and stdout to /dev/null.
# Helpers from https://gist.github.com/adamstegman/926858
def silence_output
  @orig_stderr = $stderr
  @orig_stdout = $stdout
  $stderr = File.new('/dev/null', 'w')
  $stdout = File.new('/dev/null', 'w')
end

def enable_output
  $stderr = @orig_stderr
  $stdout = @orig_stdout
  @orig_stderr = nil
  @orig_stdout = nil
end
