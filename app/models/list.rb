class List < ApplicationRecord
  has_many :items, inverse_of: :list
  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true
end
