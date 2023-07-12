class CreateShifts < ActiveRecord::Migration[7.0]
  def change
    create_table :shifts do |t|
      t.date :date
      t.integer :start_time
      t.integer :user_id
      t.timestamps
    end
  end
end
