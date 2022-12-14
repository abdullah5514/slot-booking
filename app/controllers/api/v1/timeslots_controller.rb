class Api::V1::TimeslotsController < ApplicationController
  attr_reader :start_time, :end_time
  before_action :set_timeslot, only: %i[ show update destroy ]

  # GET /timeslots
  def index
    @timeslots = Timeslot.all

    render json: @timeslots
  end

  # GET /timeslots/1
  def show
    render json: @timeslot
  end

  # POST /timeslots
  def create
    creating_date
    @timeslot = Timeslot.new(start: start_time, end: end_time)

    if @timeslot.save
      render json: @timeslot, status: :ok
    else
      render json: @timeslot.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /timeslots/1
  def update
    if @timeslot.update(timeslot_params)
      render json: @timeslot
    else
      render json: @timeslot.errors, status: :unprocessable_entity
    end
  end

  # DELETE /timeslots/1
  def destroy
    @timeslot.destroy
  end

  private
    def set_timeslot
      @timeslot = Timeslot.find(params[:id])
    end

    def timeslot_params
      params.permit(:id, :start, :end, :duration, :date)
    end

    def creating_date
      binding.break
      date = params[:date].to_datetime.in_time_zone('Karachi')
      @start_time = Date.new(date.year, date.month, date.day).to_datetime + Time.parse(params[:start]).seconds_since_midnight.seconds
      @end_time = Date.new(date.year, date.month, date.day).to_datetime + Time.parse(params[:end]).seconds_since_midnight.seconds
    end
end
