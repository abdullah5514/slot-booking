class Api::V1::TimestampsController < ApplicationController
  
    # GET /timestamps
    def index
        render json: fetch_available_timeslot(params[:date])
        ActionCable.server.broadcast("TimestampsChannel", {message: 'hello from rails'})
    end

    # private

    def fetch_available_timeslot(selected_date)
        selected_slots = Timeslot.where('start BETWEEN ? AND ?', selected_date.to_date, selected_date.to_date + 1.day)
        available_slots = []
        first_slot = 0
        selected_indexes = []
        default_timeslots.each_with_index do |timeslot, index|
            unless (selected_slots.where(start: default_timeslots[first_slot][:start].to_datetime).present?)
                unless selected_slots.where(end: default_timeslots[index][:end].to_datetime).present?
                    if index.eql?(default_timeslots.length)
                        available_slots << default_timeslots[index + 1]
                    else
                        available_slots << default_timeslots[index]
                    end
                    
                end
            end
            first_slot += 1
        end
        available_slots
    end
    
    def default_timeslots
        default_slots = []
        count = 0
        hours_list = (0..15).to_a
        hours_list.each do |index|
            [0,15,30,45].each do  |hour|
                default_slots << { 'id': count+=1,
                                   'start': "#{start_timeslot(index, 8, hour)}",
                                   'end': "#{end_timeslot(index,8,hour,15)}"
                                }
            end
        end
        default_slots
    end

    def start_timeslot(index, index_constant, hour)
        hour_timestamp = index + index_constant <= 12 ? index + index_constant : (index + index_constant) - 12
        if index + index_constant < 12
            if hour.zero?
                "#{hour_timestamp}:00 am"
            else
                "#{hour_timestamp}:#{hour} am"
            end
        else
            if hour.zero?
                "#{hour_timestamp}:00 pm"
            else
                "#{hour_timestamp}:#{hour} pm"
            end
        end
    end
    
    def end_timeslot(index, index_constant, hour, hour_constant)
        hour_timestamp = index + index_constant <= 12 ? index + index_constant : (index + index_constant) - 12
        if index + index_constant < 12
            if (hour + hour_constant) > 59
                if (hour_timestamp + 1) == 12
                    "#{hour_timestamp + 1}:00 pm"
                else
                  "#{hour_timestamp + 1}:00 am"
                end    
            else
                "#{hour_timestamp}:#{hour + hour_constant} am"
            end
        else
            if (hour + hour_constant) > 59
                if (hour_timestamp + 1) == 12

                    "#{hour_timestamp + 1}:00 am"
                else
                    "#{hour_timestamp + 1}:00 pm"
                end
            else
                "#{hour_timestamp}:#{hour + hour_constant} pm"
            end
        end
    end
  end
