class AddPositionToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :position, :integer, default: 0
  end
end
