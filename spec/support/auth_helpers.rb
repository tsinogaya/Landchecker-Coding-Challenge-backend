module AuthHelpers
  def auth_header_for(user)
    token = JsonWebToken.encode(sub: user.id)
    { 'Authorization' => "Bearer #{token}" }
  end
end

RSpec.configure do |config|
  config.include AuthHelpers
end
