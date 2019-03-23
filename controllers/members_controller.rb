require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/member' )
also_reload( '../models/*' )

get '/members' do
  @members = Member.all
  erb(:"members/index")
end

get '/members/new' do
  erb(:"members/new")
end

get '/members/:id' do
  @members = Member.find(params[:id])
  erb(:"members/show")
end

post '/members' do
  @members = Member.new(params)
  @members.save
  erb(:"members/create")
end

get '/members/:id/edit' do
  @members = Member.find(params[:id])
  erb(:"members/edit")
end

post '/members/:id' do
  @members = Member.new(params)
  @members.update
  redirect to '/members'
end

post '/members/:id/delete' do
  @members = Member.find(params[:id])
  @members.delete
  redirect to '/members'
end
