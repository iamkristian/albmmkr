require 'spec_helper'

describe Albmmkr do

  context "#find_files" do
    subject { Albmmkr.find_files('spec/fixtures') }
    it "finds files in fixtures" do
      expect(subject).to be_a Array
    end

    it "finds 5 files" do
      expect(subject.size).to eq 5
    end

    it "holds the full path" do
      expect(subject[0]).to eq "spec/fixtures/2011-02-02 15.00.46.jpg"
    end
  end

  context "#timestamps_for_files" do
    let(:files) { Albmmkr.find_files('spec/fixtures') }
    subject { Albmmkr.timestamps_for_files(files) }

    it "makes an array" do
      expect(subject).to be_a Array
    end

    it "finds timestamps for filenames" do
      expect(subject[0][0]).to be_a String
      expect(subject[0][1]).to be_a Time
    end
  end

  context "#sort_files" do
    let(:files) { Albmmkr.find_files('spec/fixtures') }
    let(:files_with_timestamp) { Albmmkr.timestamps_for_files(files) }
    subject { Albmmkr.sort_files(files_with_timestamp) }

    it "makes an array" do
      expect(subject).to be_a Array
    end
  end

  context "#group_by" do
    let(:files) { Albmmkr.find_files('spec/fixtures') }
    let(:files_with_timestamp) { Albmmkr.timestamps_for_files(files) }
    let(:sorted_files) { Albmmkr.sort_files(files_with_timestamp) }
    subject { Albmmkr.group_by(sorted_files, :month) }

    it "makes an hash" do
      expect(subject).to be_a Hash
    end

    it "groups by year" do
      result = Albmmkr.group_by(sorted_files, :year)
      expect(result.keys.size).to eq 3
    end

    it "groups by month" do
      result = Albmmkr.group_by(sorted_files, :month)
      expect(result.keys.size).to eq 4
    end
  end

  context "#formats" do
    subject { Albmmkr.formats }

    it "contains year, month, day, hour" do
      expect(subject.keys).to eq [:year, :month, :day, :hour]
    end
  end

  context "make_key" do
    it "formats with year" do
      time = Time.now
      expect(Albmmkr.make_key(time, :year)).to eq time.year.to_s
    end

    it "formats with month" do
      time = Time.now
      expect(Albmmkr.make_key(time, :month)).to eq time.strftime("%Y-%m")
    end

    it "formats with day" do
      time = Time.now
      expect(Albmmkr.make_key(time, :day)).to eq time.strftime("%Y-%m-%d")
    end

    it "formats with hour" do
      time = Time.now
      expect(Albmmkr.make_key(time, :hour)).to eq time.strftime("%Y-%m-%d %H:00")
    end
  end
end
