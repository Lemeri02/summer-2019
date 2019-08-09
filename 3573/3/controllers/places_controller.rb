class PlacesController < ApplicationController
  get '/' do
    @places = Place.all
    erb :'/index'
  end

  get '/place/:id' do
    @place = Place.find(params['id'])
    @comments = @place.comments.includes(:user)
    erb :'/show'
  end
end
