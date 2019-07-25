require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index 
  end
  
  get '/recipes/new' do 
    erb :new 
  end
  
  post '/recipes' do 
     @recipe = Recipe.create(:name => params[:recipe][:name], 
     :ingredients => params[:recipe][:ingredients], :cook_time => params[:recipe][:cook_time])
    redirect to "/recipes/#{@recipe.id}"

  end
  
  get '/recipes/:id' do 
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end
  
  get '/recipes/:id/edit' do 
    @recipe = Recipe.find_by_id(params[:id])
    binding.pry 
    erb :edit
  end
  
  patch '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end
  
  put '/recipes/:id' do 
    
  end 
  
  delete '/recipes/:id' do 
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.destroy 
    redirect to '/recipes'
  end 

end
