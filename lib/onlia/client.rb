require "rest-client"
require "json"
require "jwt"

module Onlia
  class Client
    class ResponseError < StandardError; end

    attr_accessor :api_token, :raw_token, :decoded_token

    def initialize
      self.refresh_token
    end

    def refresh_token
      @raw_token = get_token
      @api_token = @raw_token["token"]
      @decoded_token = JWT.decode(@api_token, nil, false).first
    end

    def refresh_if_required
      if @decoded_token && @decoded_token["exp"] < Time.now.to_i
        self.refresh_token
      end
    end

    def post(endpoint, body, token = nil)
      self.refresh_if_required
      endpoint_url = "#{Onlia.configuration.base_url}/#{endpoint}"
      headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json",
      }
      headers["Authorization"] = "Bearer #{token}" if !token.nil?
      begin
        response = RestClient::Request.execute(method: :post, url: endpoint_url, payload: body.to_json, headers: headers)
        # JSON.parse(response.body)
        response
      rescue RestClient::ExceptionWithResponse => exception
        # JSON.parse(exception.response.body)
        exception.response
      rescue JSON::ParserError => exception
        puts exception.response
        exception.response
      rescue RestClient::Unauthorized, RestClient::Forbidden => exception
        puts exception.response
        exception.response
      end
    end

    def get_token
      request_body = { "apiKey": Onlia.configuration.api_key }
      post("/login", request_body)
    end

    def get_quote(params)
      post("/Auto/quote", params, @api_token)
    end

    def auto_lookup(params)
      post("/Auto/lookup", params, @api_token)
    end

    def bind_agreement(params)
      post("/Auto/bind", params, @api_token)
    end

    def property_address_validate(params)
      post("/Property/address/validate", params, @api_token)
    end

    def activate_agreement(params)
      post("/Auto/activate", params, @api_token)
    end

    def terminate_agreement(params)
      post("/auto/terminate", params, @api_token)
    end
  end
end
