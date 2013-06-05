module CSSquirt
  class ImageFile
    require "base64"

    # Public: Intialize a new ImageFile object.
    #
    # file_path - A String representing the relative path to an image file.
    #
    # Raises IOError if the file cannot be found.
    # Raises TypeError if the file is not a valid image file.
    # Raises RangeError if the file is larger than the maximum size that can be
    #   encoded as a Data URI (default: 32 kilobytes).
    def initialize(file_path)
      @file_path = file_path
      raise IOError, "No file found at path #{file_path}" unless File.exist? file_path
    end

    # Public: Returns the MIME type for the file.
    #
    # Examples
    #
    #   ImageFile.new('example.png')
    #   # => 'image/png'
    #   ImageFile.new('example.svg')
    #   # => 'image/svg+xml'
    #
    # Returns a String representation of the MIME type.
    def filetype
      `file --mime-type -b #{@file_path}`.chomp
    end

    # Public: Formats a data-uri based HTML IMG tag for the file.
    #
    # Returns the entire IMG tag as a String.
    def as_img_tag()
      "<img src='#{self.encode}' />"
    end

    # Public: Formats a CSS background image rule for the file.
    #
    # Returns the the CSS background rule as a String.
    def as_css_background()
      "background: url(#{self.encode}) no-repeat;"
    end

    # Public: Encodes file into a CSS string representation.
    #
    # Returns the Base64 encoded String with filetype information embedded.
    def encode()
      "data:image/png;base64," + self.raw_encode
    end

    # Public: file into its raw Base64 string representation.
    #
    # Returns the Base64 encoded String.
    def raw_encode()
      Base64.strict_encode64(File.read @file_path)
    end
  end
end