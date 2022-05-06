# GetSocialNetworkData.call
module GetSocialNetworkData
  class << self
    def call
      tweets, statuses, photos = []
      t1 = Thread.new {tweets = get_tweets}
      t2 = Thread.new {statuses = get_statuses}
      t3 = Thread.new {photos = get_photos}

      t1.join
      t2.join
      t3.join
      [tweets, statuses, photos]
    end

    private
    def get_tweets
      res = get_response('https://takehome.io/twitter')
      res.map{|t| t["tweet"] }
    end

    def get_statuses
      res = get_response('https://takehome.io/facebook')
      res.map{|t| t["status"] }
    end

    def get_photos
      res = get_response('https://takehome.io/instagram')
      res.map{|t| t["picture"] }
    end

    def get_response(url)
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
        {success: true, data: JSON.parse(res.body)}
      else
        {success: false}
      end
    rescue Errno::ECONNREFUSED, SocketError, Timeout::Error
      {success: false}
    end
  end
end
