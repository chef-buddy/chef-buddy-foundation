class Recipe < ActiveRecord::Base
belongs_to :user

  def new
    @response = HTTParty.get('http://chefbuddy.herokuapp.com/api/v1/random_recipe/')
  end

#  def self.save_random_recipe
#    @response = HTTParty.get('http://chefbuddy.herokuapp.com/api/v1/random_recipe/')
#    @recipe = Recipe.new(name: @response["recipeName"])
#  end

#def recipe_name
#  @response["recipeName"]
#end
#
#def large_image_url
#  @response["largeImage"]
#end
#
#def reccomendation_score
#  @response["recommendation_score"]
#end


end
