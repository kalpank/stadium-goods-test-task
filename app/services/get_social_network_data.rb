# GetSocialNetworkData.call
module GetSocialNetworkData
  BASE_URL = 'https://takehome.io'.freeze
  TWITTER_URL = "#{BASE_URL}/twitter".freeze
  FACEBOOK_URL = "#{BASE_URL}/facebook".freeze
  INSTAGRAM_URL = "#{BASE_URL}/instagram".freeze
  class << self

    def call
      tweets, statuses, photos = []
      t1 = Thread.new { tweets = fetch_tweets }
      t2 = Thread.new { statuses = fetch_statuses }
      t3 = Thread.new { photos = fetch_photos }

      t1.join
      t2.join
      t3.join
      [tweets, statuses, photos]
    end

    private
    def fetch_tweets
      res = fetch_response(TWITTER_URL)
      res.map { |t| t['tweet'] }
    end

    def fetch_statuses
      res = fetch_response(FACEBOOK_URL)
      res.map { |t| t['status'] }
    end

    def fetch_photos
      res = fetch_response(INSTAGRAM_URL)
      res.map { |t| t['picture'] }
    end

    def fetch_response(url)
      res = api_req(url)
      if res[:success]
        res[:data]
      else
        []
      end
    end

    def api_req(url)
      uri = URI(url)
      res = Net::HTTP.get_response(uri)
      if res.is_a?(Net::HTTPSuccess)
        { success: true, data: JSON.parse(res.body) }
      else
        { success: false }
      end
    rescue Errno::ECONNREFUSED, SocketError, Timeout::Error
      { success: false }
    end
  end
end
