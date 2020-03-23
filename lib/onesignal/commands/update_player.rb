# frozen_string_literal: true

module OneSignal
  module Commands
    class UpdatePlayer < BaseCommand
      def initialize player_id, body
        @player_id = player_id
        @body = body
      end

      def call
        client.update_player @player_id, @body
      end
    end
  end
end
