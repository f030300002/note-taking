class RenameRecordType < ActiveRecord::Migration[5.0]
  def change
    rename_column :records, :type, :record_type
  end
end
