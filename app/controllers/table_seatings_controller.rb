class TableSeatingsController < ApplicationController
  def show
    @guests = Guest.fetch
    @guest_tables = @guests.inject({}) { |h, g| h.merge!({g.name => g.table}) }
    @guests_by_table = @guests.group_by { |g| g.table }
  end
end
