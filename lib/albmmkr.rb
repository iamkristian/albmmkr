require "albmmkr/version"
require "albmmkr/exif"
require "progressbar"
require "columnize"
require "fileutils"

module Albmmkr
  extend self

  def index(path, group, destination)
    files = find_files(path)
    files_with_timestamp = timestamps_for_files(files)
    grouped_files = group_by(files_with_timestamp, group)

    make_albums(grouped_files, destination) if confirm(grouped_files)
  end

  # finds files in a path using the '*' glob
  def find_files(path)
    entries = Dir[path + '/*']
    entries.select! { |entry| File.file?(entry) }
  end

  def timestamps_for_files(files)
    timestamps = []
    pbar = ProgressBar.new("Timestamps", files.size)
    files.each do |file|
      exif = Albmmkr::Exif.new(file)
      date = exif.createdate || exif.filemodifydate || File::Stat.new(file).ctime
      timestamps << [file, date]
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

  def confirm(grouped_files)
    puts """Here are the albums the image sort came up with:

#{grouped_files.columnize displaywidth: 30, colsep: '  |  ', ljust: false }

Do you want me to move your files into that structure?
"""
    choice = nil
    while choice != 'yes' && choice != 'no'
      puts "Yes/No > "
      choice = $stdin.gets.chomp
    end
    choice == 'yes'
  end

  def make_albums(grouped_files, destination)
    pbar = ProgressBar.new("Moving files into albums", grouped_files.keys.size)
    grouped_files.each do |album, files|
      dir = FileUtils.mkdir_p("#{destination}/#{album}")
      files.each { |file| FileUtils.mv file, dir.first }
      pbar.inc
    end
    pbar.finish
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
