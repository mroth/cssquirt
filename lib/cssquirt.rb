require "cssquirt/version"
require "base64"

module CSSquirt
  class CSSquirter
    # def initialize
    # end

    # Publc: Makes a image file into an embedded img tag
    def self.as_img_tag(file_path)
      "<img src='#{self.encode_file(file_path)}' />"
    end

    # Public: Makes a file into an CSS background image rule
    def self.as_css_background(file_path)
      "background: url(#{self.encode_file(file_path)}) no-repeat;"
    end

    # Public: Encodes a file into a CSS string representation of it
    def self.encode_file(file_path)
      prefix = "data:image/png;base64,"
      suffix = ""
      prefix + self.raw_encode_file(file_path) + suffix
    end

    # Public: Encodes a file into its raw Base64 string representation
    def self.raw_encode_file(file_path)
      Base64.strict_encode64(File.read file_path)
    end

  end
end
