class Station < ApplicationRecord
  belongs_to :property, optional: true
  validates :station_name, length: { maximum: 30 }
end
