class GuestbookEntry
  include Virtus.model

  attribute :first_name, String
  attribute :last_name, String
  attribute :message, String
  attribute :created_at, DateTime

  def self.fetch
    session = GoogleDrive::Session.from_service_account_key(StringIO.new(ENV["GOOGLE_SERVICE_ACCOUNT"]))
    spreadsheet = session.spreadsheet_by_key(Settings.google_sheets.guestbook)
    guests = Rails.cache.fetch([Rails.env, spreadsheet.id, spreadsheet.version]) do
      worksheet = spreadsheet.worksheets[0]
      guests = worksheet.rows.drop(1).collect do |row|
        GuestbookEntry.new(first_name: row[0], last_name: row[1], message: row[2], created_at: row[3])
      end
      guests.reverse
    end
  end

  def self.create(first_name, last_name, message)
    session = GoogleDrive::Session.from_service_account_key(StringIO.new(ENV["GOOGLE_SERVICE_ACCOUNT"]))
    worksheet = session.spreadsheet_by_key(Settings.google_sheets.guestbook).worksheets[0]
    num_rows = worksheet.num_rows
    worksheet[num_rows + 1, 1] = first_name
    worksheet[num_rows + 1, 2] = last_name
    worksheet[num_rows + 1, 3] = message
    worksheet[num_rows + 1, 4] = Time.current

    worksheet.save
  end
end