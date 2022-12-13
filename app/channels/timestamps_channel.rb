class TimestampsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'TimestampsChannel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    puts('error in channel')
  end
end
