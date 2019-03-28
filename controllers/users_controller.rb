require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/member' )
also_reload( '../models/*' )

get '/users' do
  @users = Member.all
  erb(:"users/index")
end

get '/users/new' do
  erb(:"users/new")
end

get '/users/:id' do
  @users = Member.find(params[:id])
  erb(:"users/show")
end

post '/users' do
  @users = Member.new(params)
  @users.save
  redirect to "/users"
end

get '/users/:id/edit' do
  @users = Member.find(params[:id])
  erb(:"users/edit")
end

post '/users/:id' do
  @users = Member.new(params)
  @users.update
  redirect to '/users'
end

post '/users/:id/delete' do
  @users = Member.find(params[:id])
  @users.delete
  redirect to '/users'
end
