require "spec_helper"

describe ImageFileList do
  describe "#to_css" do
    it "should output a CSS document of all the files"
  end

  describe "#to_images" do
    it "should return an array of all ImageFiles" do
      fl = ImageFileList.new('spec/samples/*.png', 'spec/samples/*.gif').to_images
      fl.each { |file| file.should be_kind_of(ImageFile) }
    end
    it "should eat Exceptions and output errors to STDERR instead" do
      bad_eggs = 'spec/samples/*.mp3', 'spec/samples/toobig.gif'
      lambda { ImageFileList.new(bad_eggs).to_images }.should_not raise_error
    end
  end
end