require "albmmkr/version"
require "albmmkr/exif"
require "progressbar"

module Albmmkr
  extend self

  def index(path, group)
    files = find_files(path)
    files_with_timestamp = timestamps_for_files(files)
    grouped_files = group_by(files_with_timestamp, group)
  end
  # finds files in a path using the '*' glob
  def find_files(path)
    Dir[path + '/*']
  end

  def timestamps_for_files(files)
    timestamps = []
    pbar = ProgressBar.new("Timestamps", files.size)
    files.each do |file|
      createdate = Albmmkr::Exif.new(file).createdate
      timestamps << [file, createdate]
      pbar.inc
    end
    pbar.finish
    timestamps
  end

  def group_by(files_with_timestamp, sym)
    grouped_files = {}
    pbar = ProgressBar.new("Grouping files", files_with_timestamp.size)
    files_with_timestamp.each do |file, time|
      key = make_key(time, sym)
      grouped_files[key] = (grouped_files[key] || []) << file
      pbar.inc
    end
    pbar.finish
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
