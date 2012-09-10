class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.string :host
      t.date :date
      t.string :start_end_times

      t.timestamps
    end
  end
end
