class Property < ApplicationRecord
  PROPERTY_TYPES = %w[house apartment townhouse unit land].freeze

  has_many :watchlist_items, dependent: :destroy
  has_many :watchers, through: :watchlist_items, source: :user

  validates :title, :price_cents, :bedrooms, :property_type, :status, presence: true
  validates :property_type, inclusion: { in: PROPERTY_TYPES }

  scope :filter_by_min_price, ->(min_price) { where('price_cents >= ?', min_price.to_i * 100) if min_price.present? }
  scope :filter_by_max_price, ->(max_price) { where('price_cents <= ?', max_price.to_i * 100) if max_price.present? }
  scope :filter_by_bedrooms, ->(bedrooms) { where(bedrooms: bedrooms.to_i) if bedrooms.present? }
  scope :filter_by_property_type, ->(property_type) { where(property_type: property_type) if property_type.present? }

  after_commit :broadcast_watchers_update, on: :update, if: :saved_change_to_price_cents?

  def broadcast_watchers_update
    watchers.find_each do |watcher|
      WatchlistChannel.broadcast_to(
        watcher,
        {
          type: 'property_updated',
          property_id: id,
          price_cents: price_cents,
          status: status,
          updated_at: updated_at.iso8601
        }
      )
    end
  end
end
