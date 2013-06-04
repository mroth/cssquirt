require "cssquirt/version"
require "base64"

module CSSquirt
  class CSSquirter
    # def initialize
    # end

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
