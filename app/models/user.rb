class User < ApplicationRecord
  has_secure_password

  has_many :watchlist_items, dependent: :destroy
  has_many :watched_properties, through: :watchlist_items, source: :property

  validates :email, presence: true, uniqueness: true
end
