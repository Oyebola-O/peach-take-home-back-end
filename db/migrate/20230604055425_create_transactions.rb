class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :transaction_name
      t.string :merchant
      t.decimal :amount
      t.date :date
      t.string :category
      t.boolean :reviewed

      t.timestamps
    end
  end
end
