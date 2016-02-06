json.array!(@zips) do |zip|
  json.extract! zip, :id, :id, :city, :state, :population, :integer
  json.url zip_url(zip, format: :json)
end
