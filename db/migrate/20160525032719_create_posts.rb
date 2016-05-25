class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.decimal :price, precision: 8, scale: 2
      t.string :currency, default: "TWD"
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :posts, [:user_id, :created_at]
  end
end
