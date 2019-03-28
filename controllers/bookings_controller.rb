require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/booking' )
also_reload( '../models/*' )

get '/bookings' do
  @bookings = Booking.all
  erb(:"bookings/index")
end

get '/bookings/new' do
  @members = Member.all
  @sessions = Session.all
  erb(:"bookings/new")
end

get '/bookings/:id' do
  @bookings = Booking.find(params[:id])
  erb(:"bookings/show")
end

post '/bookings' do
  @session = Session.find(params[:session_id])
  if @session.capacity > @session.attendance.count
    @bookings = Booking.new(params)
    @bookings.save
    redirect to "/bookings/#{@bookings.id}"
  end
  redirect to "/sessions/#{@session.id}/full"
end

post '/bookings/:id/delete' do
  @booking = Booking.find(params[:id])
  @booking.delete
  redirect to '/bookings'
end
