module Api
  module V1
    class PropertiesController < ApplicationController
      include Authenticatable

      DEFAULT_PER_PAGE = 20
      MAX_PER_PAGE = 100

      def index
        page = params.fetch(:page, 1).to_i.clamp(1, 10_000)
        per_page = params.fetch(:per_page, DEFAULT_PER_PAGE).to_i.clamp(1, MAX_PER_PAGE)

        cache_key = [
          'properties:index',
          page,
          per_page,
          params[:min_price],
          params[:max_price],
          params[:bedrooms],
          params[:property_type]
        ].join(':')

        payload = Rails.cache.fetch(cache_key, expires_in: 30.seconds) do
          relation = Property.order(listed_at: :desc)
                             .filter_by_min_price(params[:min_price])
                             .filter_by_max_price(params[:max_price])
                             .filter_by_bedrooms(params[:bedrooms])
                             .filter_by_property_type(params[:property_type])

          total = relation.count
          records = relation.offset((page - 1) * per_page).limit(per_page)

          {
            data: records.map { |property| PropertySerializer.render(property) },
            meta: {
              page: page,
              per_page: per_page,
              total: total,
              total_pages: (total.to_f / per_page).ceil
            }
          }
        end

        render json: payload
      end

      def show
        property = Property.find(params[:id])
        render json: { data: PropertySerializer.render(property) }
      end
    end
  end
end
