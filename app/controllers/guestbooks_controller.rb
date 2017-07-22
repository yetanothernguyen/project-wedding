class GuestbooksController < ApplicationController
  def show
    @entries = GuestbookEntry.fetch
  end

  def create
    GuestbookEntry.create(params[:name], params[:message])

    redirect_to guestbook_path
  end
end
