class AddColumnToTransaction < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :user_id, :integer
  end
end