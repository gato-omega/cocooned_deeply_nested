class Subitem < ApplicationRecord
  belongs_to :item

  has_many :microitems, inverse_of: :subitem
  accepts_nested_attributes_for :microitems, reject_if: :all_blank, allow_destroy: true
end
