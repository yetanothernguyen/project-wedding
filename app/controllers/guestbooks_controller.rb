class GuestbooksController < ApplicationController
  def show
    @entries = GuestbookEntry.fetch
  end

  def create
    GuestbookEntry.create(params[:first_name], params[:last_name], params[:message])

    redirect_to guestbook_path
  end
end
