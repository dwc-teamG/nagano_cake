class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.integer :customers_id
      t.string :post_number
      t.string :address
      t.string :name

      t.timestamps
    end
  end
end
