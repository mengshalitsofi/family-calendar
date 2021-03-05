class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.string :event_time
      t.string :location
      t.integer :user_id
    end    
  end
end
