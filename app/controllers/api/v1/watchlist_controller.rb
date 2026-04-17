module Api
  module V1
    class WatchlistController < ApplicationController
      include Authenticatable

      def index
        properties = current_user.watched_properties.order(updated_at: :desc)
        render json: { data: properties.map { |property| PropertySerializer.render(property) } }
      end

      def create
        property = Property.find(params.require(:property_id))
        watchlist_item = current_user.watchlist_items.new(property: property)

        if watchlist_item.save
          render json: { data: PropertySerializer.render(property) }, status: :created
        else
          render json: { errors: watchlist_item.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        watchlist_item = current_user.watchlist_items.find_by!(property_id: params.require(:property_id))
        watchlist_item.destroy!
        head :no_content
      end
    end
  end
end
