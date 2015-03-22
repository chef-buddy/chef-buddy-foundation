class GetRandomRecipe
  def get_random_recipe
    @response = HTTParty.get(http://chefbuddy.herokuapp.com/api/v1/random_recipe/)
  end
end
