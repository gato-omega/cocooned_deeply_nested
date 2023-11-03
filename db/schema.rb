# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_11_03_202155) do
  create_table "items", force: :cascade do |t|
    t.string "name"
    t.integer "list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 0
    t.index ["list_id"], name: "index_items_on_list_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "microitems", force: :cascade do |t|
    t.string "name"
    t.integer "subitem_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 0
    t.index ["subitem_id"], name: "index_microitems_on_subitem_id"
  end

  create_table "subitems", force: :cascade do |t|
    t.string "name"
    t.integer "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 0
    t.index ["item_id"], name: "index_subitems_on_item_id"
  end

  add_foreign_key "items", "lists"
  add_foreign_key "microitems", "subitems"
  add_foreign_key "subitems", "items"
end
