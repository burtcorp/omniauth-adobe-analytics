require 'oauth2'
require 'omniauth/strategies/oauth2'

OAuth2::Response.register_parser(:adobe_analytics, []) do |body|
  JSON.parse(body) rescue body
end

module OmniAuth
  module Strategies
    class AdobeAnalytics < OmniAuth::Strategies::OAuth2
      USER_INFO_URL = "https://ims-na1.adobelogin.com/ims/userinfo/v2",
      option :name, "adobe_analytics_oauth2"
      option :client_options,
             site: 'https://ims-na1.adobelogin.com',
             authorize_url: 'https://ims-na1.adobelogin.com/ims/authorize/v2',
             token_url: 'https://ims-na1.adobelogin.com/ims/token/v3'


      def authorize_params
        super.tap do |params|
          params[:client_id] = options.client_id
        end
      end

      uid{ raw_info['id'] }

      info do
        {
          email: raw_info['email'],
          name: raw_info['name'],
          id: raw_info['sub'],
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      # Remove params as callback URL must match exactly the URL defined for the application
      def callback_url
        super.split('?').first
      end

      def token_params
        options.token_params.merge(
          authorization_code: request.params["code"],
          grant_type: 'authorization_code',
          authorization: "Basic #{Base64.strict_encode64("#{options.client_id}:#{options.client_secret}")}",
          client_id: options.client_id,
          parse: :adobe_analytics,
        )
      end

      def raw_info
        @raw_info ||= access_token.get("#{USER_INFO_URL}?client_id=#{options.client_id}", headers: headers, parse: :adobe_analytics).parsed
      end

      def headers
        {
          'ACCESS_TOKEN' => access_token.token,
        }
      end
    end
  end
end