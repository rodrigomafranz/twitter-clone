class AddDeletedAtToFellowships < ActiveRecord::Migration[7.0]
  def change
    add_column :fellowships, :deleted_at, :datetime
  end
end
