require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/session' )
also_reload( '../models/*' )

get '/sessions' do
  @sessions = Session.all
  erb(:"sessions/index")
end

get '/sessions/new' do
  erb(:"sessions/new")
end

get '/sessions/:id' do
  @sessions = Session.find(params[:id])
  erb(:"sessions/show")
end

post '/sessions' do
  @sessions = Session.new(params)
  @sessions.save
  erb(:"sessions/create")
end

get '/sessions/:id/edit' do
  @sessions = Session.find(params[:id])
  erb(:"sessions/edit")
end

post '/sessions/:id' do
  @sessions = Session.new(params)
  @sessions.update
  redirect to '/sessions'
end

post '/sessions/:id/delete' do
  @sessions = Session.find(params[:id])
  @sessions.delete
  redirect to '/sessions'
end
