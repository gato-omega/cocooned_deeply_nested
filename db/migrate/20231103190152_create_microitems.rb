class CreateMicroitems < ActiveRecord::Migration[7.1]
  def change
    create_table :microitems do |t|
      t.string :name
      t.references :subitem, null: false, foreign_key: true

      t.timestamps
    end
  end
end
