class Api::V1::TimestampsController < ApplicationController
  
    # GET /timestamps
    def index
        timeslots = fetch_available_timeslot(Time.zone.parse(params[:date]).getutc())
        render json: timeslots
        # ActionCable.server.broadcast("TimestampsChannel", {messasge: {start: 'asdf'}})
    end

    # private

    def fetch_available_timeslot(selected_date)
        selected_slots = Timeslot.where('start BETWEEN ? AND ?', selected_date.to_date, selected_date.to_date + 1.day)
        available_slots = []
        first_slot = 0
        end_index = 0
        pre_recorded_timeslots = default_timeslots 
        selected_indexes = []
        booked_slots = []
        if selected_slots.present? 
            pre_recorded_timeslots.each_with_index do |timeslot, index|
                if selected_slots.where(start: (pre_recorded_timeslots[first_slot][:start].to_datetime.in_time_zone('Karachi'))).present?
                    unless selected_slots.where(end: default_timeslots[index][:end].to_datetime.in_time_zone('Karachi')).present?
                    else
                        booked_slots += default_timeslots[first_slot..index]
                        first_slot += 1
                    end
                else
                    first_slot += 1
                end
            end
            pre_recorded_timeslots - booked_slots

        else
            default_timeslots
        end
        
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
