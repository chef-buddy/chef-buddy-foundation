json.array!(@recipes) do |recipe|
  json.extract! recipe, :id, :name, :url, :picture
  json.url recipe_url(recipe, format: :json)
end
