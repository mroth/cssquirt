require "spec_helper"
include CSSquirt

describe CSSquirter do
  before(:each) do
    @img_rocket = 'spec/samples/16px_rocket.png'
    @img_bomb = 'spec/samples/64px_bomb.png'
  end

  describe ".new" do
    it "should return an instance of a "
  end

  describe ".as_img_tag" do
    it "should return the encoded image as an image tag" do
      CSSquirter.as_img_tag(@img_rocket).should eq("<img src='#{CSSquirter.encode_file(@img_rocket)}' />")
    end
  end

  describe ".as_css_background" do
    it "should return the encoded image as a CSS background rule" do
      CSSquirter.as_css_background(@img_rocket).should eq("background: url(#{CSSquirter.encode_file(@img_rocket)}) no-repeat;")
    end
  end

  describe ".encode_file" do
    it "should return the base64 string wrapped in proper CSS format" do
      prefix = "data:image/png;base64,"
      suffix = ""
      CSSquirter.encode_file(@img_rocket).should eq(prefix + CSSquirter.raw_encode_file(@img_rocket) + suffix)
    end
  end

  describe ".raw_encode_file" do
    it "should properly encode the file" do
      CSSquirter.raw_encode_file(@img_rocket).should eq("iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAACIlBMVEUAAAASERMUExQXFhYmJSgnJilhYGZ9AABCQEWLAAAuLC87OT3D2voeHR4mIiOdRQAmISLnYgBgAgKDAACAAACMAAB7AQCBAAAFBAU2NTk/PkI3NToAAAAzMTVVU1h1dHyMjJVqaXA+PEEAAAAwLjFQTlN9e4OpqbJ/fYY8Oj8aGRs5NztlZGpraXAaGRs8Oj50c3qOi5VTUVd8AAB8AABeAAA8LzJ0dHxubHM6ODyHAACUAACPAABQT1R+AACVAACnAABgZG4zMTSAAACOAACTAABqdII9PkV+AAByAABuBwBWNTRqdYRAREsUDAiRQwC3SAGSSzlANjsUEhCxZwDYaQFdAACJTgDGlQBiMR1PKypjEBGPAACjagDUsQCxaQC7SQFwCgB5AACfZwC/lgDSsQDGlgC0ZwCVQQByAACOAACWAACVXQCfZwCMTgCAAACAAADJydPFxM+fnqe/v8na2uXa2eSwrbm0tb9zdHhWVliKiY/CwMzDxdKrrbhRUVFlZWRNTU6al6FbEBFnYmi4usbJzNm7u8hoaGtKSkpcW1+BgYyGAQFZPUGipK/Dw9DItMDGws+trLeNi5OMjptiEBF2dHy4tcHXbXS+MTWwo66qqLOXmqeXipPcVFm8Bwd0OT2cmqSSlKLVMTbAAgJnIyZzcXmFiJRjZHDpHQi+AABdEhVUUFVlYmlaP0RbERLvWwB1GQOGAgLjmwCiWgCnAABpx48CAAAAcXRSTlMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADFTATAh9cnc7SMQEnh9n7zRYIZNudCYT2+1sVYGmU9tgfFKH9hxqk/toocbvY9mULBzLZ+IUICoTylAlc9msNtfHZ/vwt4faFMhRG5OK1WwoIuqQaRQ1yG1EyGzIAAACzSURBVBgZRcExSgNhEIbh752d2d+NBxCsrARBBAuvkIhYCtp7Km8gAYONqawUscwBgqZPCkURxMrZzUKeB22wQ1LPdllTp9ojnTHF1fJ9GJHiw5XiAE5JD7F0lUPSkFbBvDmGEb14HvgJnNO7i+0fD2hYG9cvJouIaencl2Lfstd64+lLcgsu6PjjpyQfcvVXbuFy/I6S1XU1mJSyrBZHKHFNbzZfKVnT/G7dTBYRbyu1/gH1JiFHBs2I5wAAAABJRU5ErkJggg==")
    end
    it "should raise an error if file is above 32KB"
  end
end
