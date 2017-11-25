class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.belongs_to :user, index: true
      t.text :description
      t.date :note_date, default: Time.now
      t.timestamps
    end
  end
end
