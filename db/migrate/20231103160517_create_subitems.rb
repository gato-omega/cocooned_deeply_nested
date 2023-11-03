class CreateSubitems < ActiveRecord::Migration[7.1]
  def change
    create_table :subitems do |t|
      t.string :name
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
