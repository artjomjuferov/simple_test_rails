class CreateGroupEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :group_events do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.string :location
      t.date :date_start
      t.integer :duration
      t.boolean :deleted
      t.boolean :published

      t.timestamps
    end
  end
end
