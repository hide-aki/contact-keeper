require 'jwt'

class JsonWebToken
  def self.encode(payload)
    payload.reverse_merge!(meta)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base)
  end

  def self.valid_payload(payload)
    if expired(payload) || payload['iss'] != meta[:iss] || payload['aud'] != meta[:aud]
      return false
    else
      return true
    end
  end

  def self.meta
    # expiration, issuer, audience
    {
      exp: 30.days.from_now.to_i,
      iss: 'Contact Keeper',
      aud: 'client',
    }
  end

  def self.expired(payload)
    Time.at(payload['exp']) < Time.now
  end
end
