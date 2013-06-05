require "spec_helper"

describe ImageFile do

  describe ".new" do
    it "should return an ImageFile object" do
      ImageFile.new('spec/samples/example.gif').should be_kind_of(ImageFile)
    end
    it "should raise an error if filepath is not valid" do
      lambda { ImageFile.new('spec/samples/doesnt_exist.lol') }.should raise_error(IOError)
    end
    it "should raise an error if filepath does not represent a valid image file" do
      lambda { ImageFile.new('spec/samples/example.mp3') }.should raise_error(TypeError)
    end
    it "should raise an error if file is above 32KB" do
      lambda { ImageFile.new('spec/samples/toobig.gif') }.should raise_error(RangeError)
    end
  end

  context "instance methods" do
    before(:all) do
      @img_png = ImageFile.new 'spec/samples/16px_rocket.png'
      @img_png2 = ImageFile.new 'spec/samples/64px_bomb.png'
      @img_gif = ImageFile.new 'spec/samples/example.gif'
      @img_jpg = ImageFile.new 'spec/samples/example.jpg'
      @img_svg = ImageFile.new 'spec/samples/example.svg'
    end

    describe "#filetype" do
      it "should return image/png for PNG files" do
        @img_png.filetype.should eq('image/png')
      end
      it "should return image/gif for GIF files" do
        @img_gif.filetype.should eq('image/gif')
      end
      it "should return image/jpeg for JPG files" do
        @img_jpg.filetype.should eq('image/jpeg')
      end
      it "should return image/svg+xml for SVG files" do
        @img_svg.filetype.should eq('image/svg+xml')
      end
    end

    describe "#as_img_tag" do
      it "should return the encoded image as an image tag" do
        @img_png.as_img_tag.should eq("<img src='#{@img_png.encode}' />")
      end
    end

    describe "#as_css_background_with_class" do
      it "should return the encoded image as a full CSS rule" do
        @img_gif.as_css_background_with_class().should match(/^\.\w+ \{\n(.*)\n\}/)
      end
      it "should use the filename base as the default class name" do
        @img_gif.as_css_background_with_class().should match(/^\.example_gif \{/)
      end
      it "should use an optional class name if passed one" do
        @img_gif.as_css_background_with_class('funkytown').should match(/^\.funkytown \{/)
      end
      it "should modify invalid filenames to be valid CSS class names"
      it "should raise an error if sent an invalid CSS class name"
    end

    describe "#as_css_background" do
      it "should return the encoded image as a CSS background rule" do
        @img_png.as_css_background.should eq("background: url(#{@img_png.encode}) no-repeat;")
      end
    end

    describe "#encode" do
      it "should return the base64 string wrapped in proper CSS format" do
        png_prefix = "data:image/png;base64,"
        @img_png.encode.should eq(png_prefix + @img_png.raw_encode)
        svg_prefix = "data:image/svg+xml;base64,"
        @img_svg.encode.should eq(svg_prefix + @img_svg.raw_encode)
      end
    end

    describe "#raw_encode" do
      it "should properly encode the file" do
        @img_png.raw_encode.should eq("iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAACIlBMVEUAAAASERMUExQXFhYmJSgnJilhYGZ9AABCQEWLAAAuLC87OT3D2voeHR4mIiOdRQAmISLnYgBgAgKDAACAAACMAAB7AQCBAAAFBAU2NTk/PkI3NToAAAAzMTVVU1h1dHyMjJVqaXA+PEEAAAAwLjFQTlN9e4OpqbJ/fYY8Oj8aGRs5NztlZGpraXAaGRs8Oj50c3qOi5VTUVd8AAB8AABeAAA8LzJ0dHxubHM6ODyHAACUAACPAABQT1R+AACVAACnAABgZG4zMTSAAACOAACTAABqdII9PkV+AAByAABuBwBWNTRqdYRAREsUDAiRQwC3SAGSSzlANjsUEhCxZwDYaQFdAACJTgDGlQBiMR1PKypjEBGPAACjagDUsQCxaQC7SQFwCgB5AACfZwC/lgDSsQDGlgC0ZwCVQQByAACOAACWAACVXQCfZwCMTgCAAACAAADJydPFxM+fnqe/v8na2uXa2eSwrbm0tb9zdHhWVliKiY/CwMzDxdKrrbhRUVFlZWRNTU6al6FbEBFnYmi4usbJzNm7u8hoaGtKSkpcW1+BgYyGAQFZPUGipK/Dw9DItMDGws+trLeNi5OMjptiEBF2dHy4tcHXbXS+MTWwo66qqLOXmqeXipPcVFm8Bwd0OT2cmqSSlKLVMTbAAgJnIyZzcXmFiJRjZHDpHQi+AABdEhVUUFVlYmlaP0RbERLvWwB1GQOGAgLjmwCiWgCnAABpx48CAAAAcXRSTlMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADFTATAh9cnc7SMQEnh9n7zRYIZNudCYT2+1sVYGmU9tgfFKH9hxqk/toocbvY9mULBzLZ+IUICoTylAlc9msNtfHZ/vwt4faFMhRG5OK1WwoIuqQaRQ1yG1EyGzIAAACzSURBVBgZRcExSgNhEIbh752d2d+NBxCsrARBBAuvkIhYCtp7Km8gAYONqawUscwBgqZPCkURxMrZzUKeB22wQ1LPdllTp9ojnTHF1fJ9GJHiw5XiAE5JD7F0lUPSkFbBvDmGEb14HvgJnNO7i+0fD2hYG9cvJouIaencl2Lfstd64+lLcgsu6PjjpyQfcvVXbuFy/I6S1XU1mJSyrBZHKHFNbzZfKVnT/G7dTBYRbyu1/gH1JiFHBs2I5wAAAABJRU5ErkJggg==")
      end
    end
  end
end