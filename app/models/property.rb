class Property < ApplicationRecord
  has_many :stations, dependent: :destroy
  accepts_nested_attributes_for :stations, reject_if: :all_blank, allow_destroy: true
  with_options presence: true do
    validates :name, length: { maximum: 30 }
    validates :price, numericality: { greater_than: 0}
    validates :address, length: { maximum: 30 }
    validates :year, numericality: {greater_than_or_equal_to: 0}
  end
end