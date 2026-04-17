class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :title, null: false
      t.string :address, null: false
      t.string :property_type, null: false
      t.integer :bedrooms, null: false
      t.integer :bathrooms, null: false, default: 1
      t.integer :price_cents, null: false
      t.string :status, null: false, default: 'active'
      t.datetime :listed_at, null: false

      t.timestamps
    end

    add_index :properties, :property_type
    add_index :properties, :bedrooms
    add_index :properties, :price_cents
    add_index :properties, :listed_at
    add_index :properties, %i[property_type bedrooms price_cents], name: 'idx_properties_search_filters'
  end
end
