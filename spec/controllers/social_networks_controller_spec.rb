require 'rails_helper'

RSpec.describe SocialNetworksController, type: :controller do

  let(:tweets) { ['some tweets'] }
  let(:statuses) { ['some statuses'] }
  let(:photos) { ['some pictures'] }
  let(:res) { { 'twitter' => tweets, 'facebook' => statuses, 'instagram' => photos } }

  it 'should return valid response api success' do
    expect(GetSocialNetworkData).to receive(:call).and_return([tweets, statuses, photos])

    get :index

    expect(response.status).to eq(200)
    body = JSON.parse(response.body)
    expect(body).to eq(res)
  end
end
