require "test_helper"

class TimeslotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @timeslot = timeslots(:one)
  end

  # test "should get index" do
  #   get timeslots_url, as: :json
  #   assert_response :success
  # end

  # test "should create timeslot" do
  #   assert_difference("Timeslot.count") do
  #     post timeslots_url, params: { timeslot: { end: @timeslot.end, start: @timeslot.start } }, as: :json
  #   end

  #   assert_response :created
  # end

  # test "should show timeslot" do
  #   get timeslot_url(@timeslot), as: :json
  #   assert_response :success
  # end

  # test "should update timeslot" do
  #   patch timeslot_url(@timeslot), params: { timeslot: { end: @timeslot.end, start: @timeslot.start } }, as: :json
  #   assert_response :success
  # end

  # test "should destroy timeslot" do
  #   assert_difference("Timeslot.count", -1) do
  #     delete timeslot_url(@timeslot), as: :json
  #   end

  #   assert_response :no_content
  # end
end
