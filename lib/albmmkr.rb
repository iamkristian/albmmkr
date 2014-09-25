require "albmmkr/version"
require "albmmkr/exif"

module Albmmkr
  extend self

  # finds files in a path using the '*' glob
  def find_files(path)
    Dir[path + '/*']
  end

  def timestamps_for_files(files)
    timestamps = []
    files.each do |file|
      createdate = Albmmkr::Exif.new(file).createdate
      timestamps << [file, createdate]
    end
    timestamps
  end

  def group_by(files_with_timestamp, sym)
    grouped_files = {}
    files_with_timestamp.each do |file, time|
      key = make_key(time, sym)
      grouped_files[key] = (grouped_files[key] || []) << file
    end
    grouped_files
  end

  def make_key(time, sym)
    time.strftime(formats[sym])
  end

  def formats
    { year: "%Y", month: "%Y-%m", day: "%Y-%m-%d", hour: "%Y-%m-%d %H:00" }
  end

  # Sorts an array with [file, timestamp]
  def sort_files(files)
    files.sort! { |x,y| x[1] <=> y[1] }
  end
end
