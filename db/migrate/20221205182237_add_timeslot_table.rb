class AddTimeslotTable < ActiveRecord::Migration[7.0]
  def change
    create_table :timeslots, id: :uuid do |t|
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
