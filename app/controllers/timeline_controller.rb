class TimelineController < ApplicationController
  def index
    @message  = Message.new

    @pagy, @messages = pagy(Message.order(created_at: :desc))
    
  end
end
