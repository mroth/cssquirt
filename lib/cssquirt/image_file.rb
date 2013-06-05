module CSSquirt
  class ImageFile
    require "base64"

    def initialize(file_path)
      @file_path = file_path
    end

    def filetype
      `file --mime-type -b #{@file_path}`.chomp
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