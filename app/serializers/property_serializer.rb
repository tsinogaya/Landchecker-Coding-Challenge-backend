class PropertySerializer
  def self.render(property)
    {
      id: property.id,
      title: property.title,
      address: property.address,
      property_type: property.property_type,
      bedrooms: property.bedrooms,
      bathrooms: property.bathrooms,
      price_cents: property.price_cents,
      status: property.status,
      listed_at: property.listed_at,
      updated_at: property.updated_at
    }
  end
end
