class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title
      t.references :user, foreign_key: true
      t.timestamp :purchased_at
      t.integer :warranty_time

      t.timestamps
    end
  end
end
