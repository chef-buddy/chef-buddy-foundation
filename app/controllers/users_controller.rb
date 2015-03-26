class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy,]
  before_action :post_suggested_recipe, only: [:index, :show, :random]

  # GET /users
  # GET /users.json
  def index
    @recipes = Recipe.all
    @recipe = Recipe.new
    @user = User.find_by_id(current_user.id)
  end

#http://chefbuddy.herokuapp.com/api/v1/recipe_list/?user=2&filter=paleo&filter=dairy

  def recipe_list
    temp_string = ""
    temp_options = params["filters"] || []
    temp_search = params["search"] || []

    temp_options.each do |to|
      temp_string += "&filter=#{to}"
    end
    @user = User.find_by_id(current_user.id)
    @response = HTTParty.get("http://chefbuddy.herokuapp.com/api/v1/recipe_list/?user=#{current_user.id}&" + "#{temp_string}" +"&search=#{temp_search}")
    @options = ["dairy", "egg", "gluten", "sesame", "soy", "sulfite", "nut",
      "wheat", "lacto", "ovo", "pescetarian", "vegan", "vegetarian", "paleo"]
  end

  def random
    @users = User.all
  end

  def random
    @response = HTTParty.post('http://chefbuddy.herokuapp.com/api/v1/suggested_recipe/')
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

 def try
   @user = User.find_by_id(current_user.id)
   @recipes = Recipe.all
   @response = HTTParty.post('http://chefbuddy.herokuapp.com/api/v1/suggested_recipe/',
   body: { liked: "1",
     user: "#{current_user.id}",
     recipe: params[:recipe_id],
   })
    Recipe.find_or_create_by(name: params[:recipe_name], url: params[:recipe_url],
    picture: params[:recipe_large_image], user_id: current_user.id)
    render 'index'
end


def trash
  @user = User.find_by_id(current_user.id)
  @recipes = Recipe.all
  @response = HTTParty.post('http://chefbuddy.herokuapp.com/api/v1/suggested_recipe/',
  body: { liked: "-1",
    user: "#{current_user.id}",
    recipe: params[:recipe_id],
    })
    render 'index'
end


#def pass
#  @response = HTTParty.post('http://chefbuddy.herokuapp.com/api/v1/suggested_recipe/',
#  :body => { :liked => '0',
#    :user => "#{current_user.id}",
#    :id => params[:recipe_id],
#  }.to_json,
#  :headers => {'Content-Type' => 'application/json'},
#  )
#  render 'index'
#end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # Use callbacks to share common setup or constraints between actions.
  private def set_user
    @user = User.find(params[:id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  private def user_params
    params.require(:user).permit(:first_name, :last_name, :uid, :provider, recipe_attributes: [:name, :url, :picture])
  end
  private def get_a_random_recipe
    @response = HTTParty.post('http://chefbuddy.herokuapp.com/api/v1/random_recipe/')
  end

  private def post_suggested_recipe
    @response = HTTParty.post('http://chefbuddy.herokuapp.com/api/v1/suggested_recipe/')
  end

end
