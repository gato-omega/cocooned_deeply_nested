json.extract! microitem, :id, :name, :subitem_id, :created_at, :updated_at
json.url microitem_url(microitem, format: :json)
