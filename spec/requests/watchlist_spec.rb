require 'rails_helper'

RSpec.describe 'Watchlist API', type: :request do
  let(:user) { User.create!(email: 'watch@x.com', password: 'secret123', password_confirmation: 'secret123') }
  let(:property) do
    Property.create!(title: 'Track Me', address: '99 C St', property_type: 'townhouse', bedrooms: 4, bathrooms: 2, price_cents: 900_000_00, status: 'active', listed_at: Time.current)
  end

  it 'adds and removes a watchlist item' do
    post "/api/v1/watchlist/#{property.id}", headers: auth_header_for(user)
    expect(response).to have_http_status(:created)

    delete "/api/v1/watchlist/#{property.id}", headers: auth_header_for(user)
    expect(response).to have_http_status(:no_content)
  end
end
