# frozen_string_literal: true

module Google
  class SpreadsheetsService
    CONFIGS = Settings.google.auth_keys.freeze
    POKER_ASSETS_TOURNAMENT_DOC_ID = Settings.google.poker.assets.tournaments.doc_id

    attr_reader :spreadsheet_session

    def initialize
      @spreadsheet_session = GoogleDrive::Session.new(build_credentials)
    end

    def worksheet
      spreadsheet_session.spreadsheet_by_key(POKER_ASSETS_TOURNAMENT_DOC_ID).worksheets.first
    end

    class << self
      def parse_tournaments
        Tournament.destroy_all

        tables = new.worksheet.rows.split(['', '', '', '', '', '', '']) - [[]]

        tables.each do |table|
          number, title = table[0][0].gsub('SHRS Europe Ev #', '').split(': ')
          data = table[1]
          players = table[2..-1]

          Tournament.create(
            number: number,
            title: title,
            points_qualification: humanize_float(data[2]),
            prize_pool: humanize_money(data[3]),
            buy_in: humanize_money(data[4]),
            entrants: data[5],
            final_date: humanize_date(data[6])
          ) do |t|
            t.players_tournaments.build(
              players.map do |player|
                {
                  place: player[0],
                  player: Player.find_or_create_by(full_name: player[1]),
                  points_qualification: player[2],
                  prize_pool: humanize_money(player[3])
                }
              end
            )
          end
        end
      end

      def humanize_money(number)
        number.gsub('$', '').split(',').join.to_i
      end

      def humanize_float(number)
        number.gsub(',', '.').to_f
      end

      def humanize_date(date)
        date_arr = date.split('/')
        date_str = [date_arr[2], date_arr[0], date_arr[1]].join('-')

        Date.parse(date_str)
      end
    end

    private

    def build_credentials
      Google::Auth::ServiceAccountCredentials.new(
        scope: GoogleDrive::Session::DEFAULT_SCOPE,
        token_credential_uri: Google::Auth::ServiceAccountCredentials::TOKEN_CRED_URI,
        audience: Google::Auth::ServiceAccountCredentials::TOKEN_CRED_URI,
        signing_key: OpenSSL::PKey::RSA.new(CONFIGS.private_key),
        issuer: CONFIGS.client_email,
        project_id: CONFIGS.project_id
      ).configure_connection({})
    end
  end
end
