# frozen_string_literal: true

module OneSignal
  module Responses
    # Example JSON
    # {
    #   "csv_file_url": "https://onesignal.s3.amazonaws.com/csv_exports/test/users_abc123.csv.gz"
    # }
    class Update < BaseResponse
      ATTRIBUTES_WHITELIST = %i[success].freeze

      def self.from_json json
        body = json.is_a?(String) ? JSON.parse(json) : json
        new(body)
      end
    end
  end
end
