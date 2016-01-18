class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title
      t.text :body
      t.integer :owner_id, foreign_key: true
      t.boolean :private, default: false
      # t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end

    add_index :wikis, :id, unique: true

  end
end
