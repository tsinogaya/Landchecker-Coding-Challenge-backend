require 'rails_helper'

RSpec.describe 'Properties API', type: :request do
  let(:user) { User.create!(email: 'test@x.com', password: 'secret123', password_confirmation: 'secret123') }

  before do
    Property.create!(title: 'Low House', address: '1 A St', property_type: 'house', bedrooms: 2, bathrooms: 1, price_cents: 500_000_00, status: 'active', listed_at: 3.days.ago)
    Property.create!(title: 'High Apartment', address: '2 B St', property_type: 'apartment', bedrooms: 3, bathrooms: 2, price_cents: 1_500_000_00, status: 'active', listed_at: 1.day.ago)
  end

  it 'filters properties by price and type' do
    get '/api/v1/properties', params: { max_price: 800_000, property_type: 'house' }, headers: auth_header_for(user)

    expect(response).to have_http_status(:ok)
    body = JSON.parse(response.body)
    expect(body['data'].size).to eq(1)
    expect(body['data'].first['title']).to eq('Low House')
  end
end
