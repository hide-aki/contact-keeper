require 'httparty'

class FacebookToken
  include HTTParty

  # The base uri for facebook graph API
  base_uri 'https://graph.facebook.com/v2.9'

  # Used to authenticate app with facebook user
  # Usage
  #   Facebook.authenticate('authorization_code')
  # Flow
  #   Retrieve access_token from authorization_code
  #   Retrieve User_Info hash from access_token
  def self.authenticate(temp_token)
    access_token = get_access_token(temp_token)
    user_info    = get_user_profile(access_token)
    return user_info, access_token
  end

  # Used to revoke the application permissions and login if a user
  # revoked some of the mandatory permissions required by the application
  # like the email
  # Usage
  #    Facebook.deauthorize('user_id')
  # Flow
  #   Send DELETE /me/permissions?access_token=XXX
  def self.deauthorize(access_token)
    options  = { query: { access_token: access_token } }
    response = self.delete('/me/permissions', options)

    unless response.success?
      Rails.logger.error 'Facebook.deauthorize Failed'
    end
    response.parsed_response
  end

  def self.get_access_token(temp_token)
    response = FacebookToken.get('/oauth/access_token', query(temp_token))
    binding.pry
    unless response.success?
      Rails.logger.error 'Facebook.get_access_token Failed'
    end
    response.parsed_response['access_token']
  end

  def self.get_user_profile(access_token)
    options = { query: { access_token: access_token } }
    response = FacebookToken.get('/me', options)

    unless response.success?
      Rails.logger.error 'Facebook.get_user_profile Failed'
    end
    response.parsed_response
  end

  private

  # exchange temporary access token for long-lived token
  # https://developers.facebook.com/docs/facebook-login/access-tokens/expiration-and-extension
  def self.query(temp_token)
    {
      query: {
        fb_exchange_token: temp_token,
        grant_type: 'fb_exchange_token',
        client_id: ENV['FACEBOOK_DEV_APP_ID'],
        client_secret: ENV['FACEBOOK_DEV_SECRET_KEY']
      }
    }
  end
end
