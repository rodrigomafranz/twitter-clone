class TimelineController < ApplicationController
  def index
    @message  = Message.new
    @messages = Message.order(created_at: :desc)
  end
end
