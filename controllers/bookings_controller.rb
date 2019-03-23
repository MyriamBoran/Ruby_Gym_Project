require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/booking' )
also_reload( '../models/*' )

get '/bookings' do
  @bookings = Booking.all
  erb(:"bookings/index")
end

get '/bookings/new' do
  erb(:"bookings/new")
end

get '/bookings/:id' do
  @bookings = Booking.find(params[:id])
  erb(:"bookings/show")
end

post '/bookings' do
  @bookings = Booking.new(params)
  @bookings.save
  erb(:"bookings/create")
end

get '/bookings/:id/edit' do
  @bookings = Booking.find(params[:id])
  erb(:"bookings/edit")
end

post '/bookings/:id' do
  @bookings = Booking.new(params)
  @bookings.update
  redirect to '/bookings'
end

post '/bookings/:id/delete' do
  @booking = Booking.find(params[:id])
  @booking.delete
  redirect to '/bookings'
end
