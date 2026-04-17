class Rack::Attack
  throttle('req/ip', limit: 120, period: 1.minute) do |request|
    request.ip
  end

  throttle('logins/ip', limit: 10, period: 1.minute) do |request|
    if request.path == '/api/v1/auth/login' && request.post?
      request.ip
    end
  end
end

Rails.application.config.middleware.use Rack::Attack
