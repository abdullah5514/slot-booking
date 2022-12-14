class TimestampsChannel < ApplicationCable::Channel
  def subscribed
    # stop_all_streams
    stream_from 'TimestampsChannel'
  end

  def unsubscribed
    # stop_all_streams
    # Any cleanup needed when channel is unsubscribed
  rescue Exception => e
    binding.break
    puts(e)
  end
end
