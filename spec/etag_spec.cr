require "./spec_helper"

describe Etag do
  describe ".etag(stat : File::Stat)" do
    it "should not raise an error" do
      begin
        Etag.etag File.lstat("#{__DIR__}/fixtures/lorem.txt")
      rescue err
        err.should be_nil
      end
    end

    it "should generate a strong ETag" do
      stat = File.lstat("#{__DIR__}/fixtures/lorem.txt")
      Etag.etag(stat).should eq "\"c85-582e119c\""
    end

    it "should generate a weak ETag" do
      stat = File.lstat("#{__DIR__}/fixtures/lorem.txt")
      Etag.etag(stat, weak: true).should eq "W/\"c85-582e119c\""
    end
  end

  describe ".etag(entity : String)" do
    it "should not raise an error" do
      begin
        Etag.etag("")
        Etag.etag("Hello, etag")
      rescue err
        err.should be_nil
      end
    end

    it "should generate a strong ETag" do
      Etag.etag("how are you?").should eq "\"c-vkw0v0ngkBf+jQ2xFJLgeloPang\""
    end

    it "should generate a weak ETag" do
      Etag.etag("how are you?", weak: true).should eq "W/\"c-vkw0v0ngkBf+jQ2xFJLgeloPang\""
    end

    it "should generate a strong ETag for empty string" do
      Etag.etag("").should eq "\"0-2jmj7l5rSw0yVb/vlWAYkK/YBwk\""
    end

    it "should generate a weak ETag for empty string" do
      Etag.etag("", weak: true).should eq "W/\"0-2jmj7l5rSw0yVb/vlWAYkK/YBwk\""
    end
  end
end
