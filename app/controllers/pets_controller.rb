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
    @pet = Pet.create(params["pet"])
    if params["owner"]["id"] != nil
      exist_owner = Owner.find(params["owner"]["id"])
      @pet.owner = exist_owner
    elsif params["owner"]["name"] != nil
      new_owner = Owner.create(name: params["owner"]["name"])
      @pet.owner = new_owner
    end
      @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(name: params["pet"]["name"])
    if !params["owner"]["name"].empty?
      new_owner = Owner.create(name: params["owner"]["name"])
      @pet.owner = new_owner
    else
      selected_owner = Owner.find(params["owner"]["id"])
      @pet.owner = selected_owner
    end
      @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
