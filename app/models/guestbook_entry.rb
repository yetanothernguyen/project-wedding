class GuestbookEntry
  include Virtus.model

  attribute :name, String
  attribute :message, String
  attribute :created_at, DateTime

  def self.fetch
    session = GoogleDrive::Session.from_service_account_key(Rails.root.join("config", "service-account.json"))
    spreadsheet = session.spreadsheet_by_key(Settings.google_sheets.guestbook)
    guests = Rails.cache.fetch([Rails.env, spreadsheet.id, spreadsheet.version]) do
      worksheet = spreadsheet.worksheets[0]
      guests = worksheet.rows.drop(1).collect do |row|
        GuestbookEntry.new(name: row[0], message: row[1], created_at: row[2])
      end
      guests.reverse
    end
  end

  def self.create(name, message)
    session = GoogleDrive::Session.from_service_account_key(Rails.root.join("config", "service-account.json"))
    worksheet = session.spreadsheet_by_key(Settings.google_sheets.guestbook).worksheets[0]
    num_rows = worksheet.num_rows
    worksheet[num_rows + 1, 1] = name
    worksheet[num_rows + 1, 2] = message
    worksheet[num_rows + 1, 3] = Time.current

    worksheet.save
  end
end