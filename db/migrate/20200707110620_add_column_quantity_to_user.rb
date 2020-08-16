class AddColumnQuantityToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :count, :integer, :default => 0
    add_column :users, :total, :decimal, :default => 0

  end
end
