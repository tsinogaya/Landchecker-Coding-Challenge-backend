require 'rails_helper'

RSpec.describe 'Auth API', type: :request do
  it 'registers and logs in a user' do
    post '/api/v1/auth/register', params: {
      user: {
        email: 'newuser@x.com',
        password: 'secret123',
        password_confirmation: 'secret123'
      }
    }

    expect(response).to have_http_status(:created)

    post '/api/v1/auth/login', params: { email: 'newuser@x.com', password: 'secret123' }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)['token']).to be_present
  end
end
