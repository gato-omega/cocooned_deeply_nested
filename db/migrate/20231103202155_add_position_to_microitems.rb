class AddPositionToMicroitems < ActiveRecord::Migration[7.1]
  def change
    add_column :microitems, :position, :integer, default: 0
  end
end
