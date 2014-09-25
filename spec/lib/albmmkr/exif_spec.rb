require 'spec_helper'

describe Albmmkr::Exif do
  let(:photo) { "spec/fixtures/2012-10-21 07.26.01.jpg"  }
  subject { Albmmkr::Exif.new(photo) }

  it "can read the file" do
    expect(subject).to_not be_nil
  end

  it "can read create time" do
    expect(subject.createdate).to be_a Time
  end

  it "doesn't die with nil" do
    expect {
      Albmmkr::Exif.new("asdfasdf")
    }.to_not raise_error
  end

  it "returns nil when tool is nil" do
    expect(Albmmkr::Exif.new("asdfasdf").photo).to be_nil
  end
end
