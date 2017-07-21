class GuestbooksController < ApplicationController
  def show
  end

  def create
    session = GoogleDrive::Session.from_service_account_key(Rails.root.join("config", "service-account.json"))
    worksheet = session.spreadsheet_by_key("1-j3vsvW1pcukJf5EkeYNdc52K5suqNT5nlmR4qPRe5s").worksheets[0]
    num_rows = worksheet.num_rows
    worksheet[num_rows + 1, 1] = params[:name]
    worksheet[num_rows + 1, 2] = params[:message]
    worksheet.save

    redirect_to guestbook_path
  end
end
