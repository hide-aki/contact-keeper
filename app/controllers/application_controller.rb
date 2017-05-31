class ApplicationController < ActionController::API
  protected

  def authenticate_request
    if !payload || !JsonWebToken.valid_payload(payload.first) || !current_user
      binding.pry
      return invalid_authentication
    end
  end

  def invalid_authentication
    render json: { error: 'Invalid Request' }, status: :unauthorized
  end

  private

  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last
    JsonWebToken.decode(token)
  rescue
    nil
  end

  def current_user
    @current_user ||= User.find_by(id: payload&.first['user_id'])
  end
end
