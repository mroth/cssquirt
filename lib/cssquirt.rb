require "cssquirt/version"
require "cssquirt/image_file"

module CSSquirt
  class CSSquirter
    # def initialize
    # end

    # Publc: Makes a image file into an embedded img tag
    def self.as_img_tag(file_path)
      ImageFile.new(file_path).as_img_tag
    end

    # Public: Makes a file into an CSS background image rule
    def self.as_css_background(file_path)
      ImageFile.new(file_path).as_css_background
    end

    # Public: Encodes a file into a CSS string representation of it
    def self.encode_file(file_path)
      ImageFile.new(file_path).encode
    end

    # Public: Encodes a file into its raw Base64 string representation
    def self.raw_encode_file(file_path)
      ImageFile.new(file_path).raw_encode
    end

  end
end
