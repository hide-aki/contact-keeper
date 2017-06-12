class ApplicationController < ActionController::API
  protected

  def authenticate_request
    if !payload || !JsonWebToken.valid_payload(payload.first) || !current_user || !current_user.valid_jwt
      return invalid_authentication
    end
  end

  def invalid_authentication
    render json: { error: 'Invalid Request' }, status: :unauthorized
  end
  
  def authenticated_user
    payload.id
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
    user_id = payload ? payload.first['user_id'] : nil
    @current_user ||= User.find_by(id: user_id)
  end
end
