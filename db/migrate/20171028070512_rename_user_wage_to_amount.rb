class RenameUserWageToAmount < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :wage, :amount
  end
end
