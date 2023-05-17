require 'mini_exiftool'
require 'forwardable'
module Albmmkr
  class Exif
    extend ::Forwardable

    attr_reader :filename, :photo
    def_delegators :@photo, :filemodifydate, :title
    def initialize(filename)
      @filename = filename
      @photo = tool filename
    end

    def creationdate
      @photo['CreationDate']
    end

    def createdate
      @photo['CreateDate']
    end



    private

    def tool(filename)
      MiniExiftool.new filename
    rescue MiniExiftool::Error
      nil
    end
  end
end
