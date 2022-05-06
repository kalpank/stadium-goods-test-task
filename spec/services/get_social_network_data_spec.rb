require 'rails_helper'

RSpec.describe GetSocialNetworkData do

  context "valid api call" do
    let(:twitter_response) { JSON.parse(file_fixture("twitter.json").read) }
    let(:facebook_response) { JSON.parse(file_fixture("facebook.json").read) }
    let(:instagram_response) { JSON.parse(file_fixture("instagram.json").read) }
    let(:tweets) { twitter_response.map{|tr| tr['tweet'] } }
    let(:statuses) { facebook_response.map{|tr| tr['status'] } }
    let(:photos) { instagram_response.map{|tr| tr['picture'] } }

    before(:each) do
      stub_request(:get, "https://takehome.io/twitter").
        to_return(body: twitter_response.to_json)

      stub_request(:get, "https://takehome.io/facebook").
        to_return(body: facebook_response.to_json)

      stub_request(:get, "https://takehome.io/instagram").
        to_return(body: instagram_response.to_json)
    end

    it 'should return valid response' do
      expect(described_class.call).to eq([tweets, statuses, photos])
    end
  end

  context "api failure" do
    before(:each) do
      stub_request(:get, "https://takehome.io/twitter").
        to_return(status: [500, "Internal Server Error"])

      stub_request(:get, "https://takehome.io/facebook").
        to_return(status: [500, "Internal Server Error"])

      stub_request(:get, "https://takehome.io/instagram").
        to_return(status: [500, "Internal Server Error"])
    end

    it 'should return valid response' do
      expect(described_class.call).to eq([[], [], []])
    end
  end

  context "api timeout" do
    before(:each) do
      stub_request(:get, "https://takehome.io/twitter").
        to_timeout

      stub_request(:get, "https://takehome.io/facebook").
        to_timeout

      stub_request(:get, "https://takehome.io/instagram").
        to_timeout
    end


    it 'should return valid response' do
      expect(described_class.call).to eq([[], [], []])
    end
  end


  context "api socket error" do
    before(:each) do
      stub_request(:get, "https://takehome.io/twitter").
        to_raise(SocketError)

      stub_request(:get, "https://takehome.io/facebook").
        to_raise(SocketError)

      stub_request(:get, "https://takehome.io/instagram").
        to_raise(SocketError)
    end


    it 'should return valid response' do
      expect(described_class.call).to eq([[], [], []])
    end
  end
end
