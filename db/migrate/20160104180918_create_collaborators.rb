class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.integer :user_id, index: true
      t.integer :wiki_id, index: true
      t.timestamps
    end

    add_index :collaborators, :id, unique: true
  end
end
