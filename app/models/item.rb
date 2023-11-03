class Item < ApplicationRecord
  belongs_to :list

  has_many :subitems, inverse_of: :item
  accepts_nested_attributes_for :subitems, reject_if: :all_blank, allow_destroy: true
end
