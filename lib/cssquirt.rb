require "cssquirt/version"

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

  class ImageFile
    require "base64"

    def initialize(file_path)
      @file_path = file_path
    end

    def as_img_tag()
      "<img src='#{self.encode}' />"
    end

    def as_css_background()
      "background: url(#{self.encode}) no-repeat;"
    end

    def encode()
      "data:image/png;base64," + self.raw_encode
    end

    def raw_encode()
      Base64.strict_encode64(File.read @file_path)
    end
  end
end
