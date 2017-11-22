class AddImportantToRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :records, :important, :boolean, default: false
  end
end
