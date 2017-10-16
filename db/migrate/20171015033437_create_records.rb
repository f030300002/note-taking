class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
      t.belongs_to :user, index: true
      t.string :type
      t.string :title
      t.decimal :amount, precision: 8, scale: 2, default: 0
      t.text :description

      t.timestamps
    end
  end
end
