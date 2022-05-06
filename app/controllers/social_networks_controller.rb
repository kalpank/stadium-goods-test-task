require 'net/http'

class SocialNetworksController < ApplicationController
  def index
    tweets, statuses, photos = GetSocialNetworkData.call

    render json: { twitter: tweets, facebook: statuses, instagram: photos }
  end

end
