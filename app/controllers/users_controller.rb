class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    #@response = HTTParty.get('http://chefbuddy.herokuapp.com/api/v1/random_recipe/')

    @response = HTTParty.post('http://chefbuddy.herokuapp.com/api/v1/suggested_recipe/')
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

  def set_options
    @options = {
    body: {
        liked: '1', # your columns/data
        user: 'Roasted-Tomato-_-Yellow-Fin-Tuna-Panini-Melt-986498',
        id: '1'
    }
  }
end

 def try
   @result = HTTParty.post('http://chefbuddy.herokuapp.com/api/v1/suggested_recipe/',
   body: { liked: '1',
     user: "#{current_user.id}",
     recipe: "1000",
   }.to_json,
   headers: {'Content-Type' => 'application/json'})
 end

#  def trash
#    @result = HTTParty.post('http://chefbuddy.herokuapp.com/api/v1/suggested_recipe/',
#    :body => { :liked => '-1',
#      :user => "#{current_user.id}",
#      :recipe => "#{@result["recipeName"]}",
#    }.to_json,
#    :headers => {'Content-Type' => 'application/json'})
#  end
#
#  def pass
#    @result = HTTParty.post('http://chefbuddy.herokuapp.com/api/v1/suggested_recipe/',
#    :body => { :liked => '0',
#      :user => "#{current_user.id}",
#      :recipe => "#{@result["recipeName"]}",
#    }.to_json,
#    :headers => {'Content-Type' => 'application/json'})
#  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :uid, :provider)
    end
end
