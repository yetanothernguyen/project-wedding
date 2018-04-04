class Guest
  include Virtus.model

  attribute :name, String
  attribute :table, Integer

  def self.fetch
    session = GoogleDrive::Session.from_service_account_key(StringIO.new(ENV["GOOGLE_SERVICE_ACCOUNT"]))
    spreadsheet = session.spreadsheet_by_key(Settings.google_sheets.guest_list)
    guests = Rails.cache.fetch([Rails.env, spreadsheet.id, spreadsheet.version]) do
      worksheet = spreadsheet.worksheets[0]
      guests = worksheet.rows.drop(1).collect do |row|
        Guest.new(name: row[0], table: row[1])
      end
      guests.sort_by { |g| g.name }
    end
  end
end