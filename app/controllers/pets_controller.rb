class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    # Pet.create(params)
    # binding.pry
    if params[:owner][:owner_ids] == nil 
      @pet = Pet.create(name: params[:pet_name], owner: Owner.create(params[:owner]))
    else
      @pet = Pet.create(name: params[:pet_name], owner_id: params[:owner][:owner_ids].first)
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'pets/edit'
  end
  
  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])

    if params[:owner][:name] == ""
      @pet.update(name: params[:pet_name], owner_id: params[:owner][:owner_id])
    else
      @pet.update(name: params[:pet_name], owner: Owner.create(name: params[:owner][:name]))
    end
    
    redirect to "pets/#{@pet.id}"
  end
end