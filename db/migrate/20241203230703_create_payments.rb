class CreatePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :payments do |t|
      t.references :order, null: false, foreign_key: true
      t.decimal :amount
      t.string :payment_status
      t.datetime :payment_date

      t.timestamps
    end
  end
end
