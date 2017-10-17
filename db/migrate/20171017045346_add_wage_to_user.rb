class AddWageToUser < ActiveRecord::Migration[5.0]
  def self.up
    add_column :users, :wage, :decimal, precision: 8, scale: 2, default: 0
  end

  def self.down
    remove_column :users, :wage, :decimal
  end
end
