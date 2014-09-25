require 'mini_exiftool'
require 'forwardable'
module Albmmkr
  class Exif
    extend ::Forwardable

    attr_reader :filename, :photo
    def_delegators :@photo, :filemodifydate, :createdate, :title
    def initialize(filename)
      @filename = filename
      @photo = tool filename
    end

    private

    def tool(filename)
      MiniExiftool.new filename
    end
  end
end
