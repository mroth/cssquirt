require "cssquirt/version"
require "base64"

module CSSquirt
  class CSSquirter
    # def initialize
    # end
    
    # Public: Encodes a file into Base64 string representation
    def self.encode_file(file_path)
      Base64.strict_encode64(File.read file_path)
    end

  end
end
