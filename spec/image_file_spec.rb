require "spec_helper"

describe ImageFile do

  describe ".new" do
    it "should return an instance of a "
  end

#TODO: handle files other than pngs!!!!


  context "instance methods" do
    before(:all) do
      @img_rocket = ImageFile.new 'spec/samples/16px_rocket.png'
      @img_bomb = ImageFile.new 'spec/samples/64px_bomb.png'
    end

    describe "#as_img_tag" do
      it "should return the encoded image as an image tag" do
        @img_rocket.as_img_tag.should eq("<img src='#{@img_rocket.encode}' />")
      end
    end

    describe "#as_css_background_with_class" do
      it "should return the encoded image as a full CSS rule"
      it "should use the filename base as the default class name"
      it "should use an optional class name if passed one"
    end

    describe "#as_css_background" do
      it "should return the encoded image as a CSS background rule" do
        @img_rocket.as_css_background.should eq("background: url(#{@img_rocket.encode}) no-repeat;")
      end
    end

    describe "#encode" do
      it "should return the base64 string wrapped in proper CSS format" do
        prefix = "data:image/png;base64,"
        suffix = ""
        @img_rocket.encode.should eq(prefix + @img_rocket.raw_encode + suffix)
      end
    end

    describe "#raw_encode" do
      it "should properly encode the file" do
        @img_rocket.raw_encode.should eq("iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAACIlBMVEUAAAASERMUExQXFhYmJSgnJilhYGZ9AABCQEWLAAAuLC87OT3D2voeHR4mIiOdRQAmISLnYgBgAgKDAACAAACMAAB7AQCBAAAFBAU2NTk/PkI3NToAAAAzMTVVU1h1dHyMjJVqaXA+PEEAAAAwLjFQTlN9e4OpqbJ/fYY8Oj8aGRs5NztlZGpraXAaGRs8Oj50c3qOi5VTUVd8AAB8AABeAAA8LzJ0dHxubHM6ODyHAACUAACPAABQT1R+AACVAACnAABgZG4zMTSAAACOAACTAABqdII9PkV+AAByAABuBwBWNTRqdYRAREsUDAiRQwC3SAGSSzlANjsUEhCxZwDYaQFdAACJTgDGlQBiMR1PKypjEBGPAACjagDUsQCxaQC7SQFwCgB5AACfZwC/lgDSsQDGlgC0ZwCVQQByAACOAACWAACVXQCfZwCMTgCAAACAAADJydPFxM+fnqe/v8na2uXa2eSwrbm0tb9zdHhWVliKiY/CwMzDxdKrrbhRUVFlZWRNTU6al6FbEBFnYmi4usbJzNm7u8hoaGtKSkpcW1+BgYyGAQFZPUGipK/Dw9DItMDGws+trLeNi5OMjptiEBF2dHy4tcHXbXS+MTWwo66qqLOXmqeXipPcVFm8Bwd0OT2cmqSSlKLVMTbAAgJnIyZzcXmFiJRjZHDpHQi+AABdEhVUUFVlYmlaP0RbERLvWwB1GQOGAgLjmwCiWgCnAABpx48CAAAAcXRSTlMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADFTATAh9cnc7SMQEnh9n7zRYIZNudCYT2+1sVYGmU9tgfFKH9hxqk/toocbvY9mULBzLZ+IUICoTylAlc9msNtfHZ/vwt4faFMhRG5OK1WwoIuqQaRQ1yG1EyGzIAAACzSURBVBgZRcExSgNhEIbh752d2d+NBxCsrARBBAuvkIhYCtp7Km8gAYONqawUscwBgqZPCkURxMrZzUKeB22wQ1LPdllTp9ojnTHF1fJ9GJHiw5XiAE5JD7F0lUPSkFbBvDmGEb14HvgJnNO7i+0fD2hYG9cvJouIaencl2Lfstd64+lLcgsu6PjjpyQfcvVXbuFy/I6S1XU1mJSyrBZHKHFNbzZfKVnT/G7dTBYRbyu1/gH1JiFHBs2I5wAAAABJRU5ErkJggg==")
      end
      it "should raise an error if file is above 32KB"
    end
  end
end