class AddDateToRecord < ActiveRecord::Migration[5.0]
  def self.up
    add_column :records, :record_date, :date, default: Time.now
  end
  def self.down
    remove_column :records, :record_date, :date
  end
end
