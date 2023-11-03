class AddPositionToSubitems < ActiveRecord::Migration[7.1]
  def change
    add_column :subitems, :position, :integer, default: 0
  end
end
