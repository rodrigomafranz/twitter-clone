class CreateFellowships < ActiveRecord::Migration[7.0]
  def change
    create_table :fellowships do |t|
      t.references :follower_user, null: false, foreign_key: { to_table: :users}
      t.references :followed_user, null: false, foreign_key: { to_table: :users}

      t.timestamps
    end
  end
end
