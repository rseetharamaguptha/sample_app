class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :microposts, :users
    # Because we retrieve posts from the user in the reverse order
    add_index :microposts, [ :user_id, :created_at]
  end
end