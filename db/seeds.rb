require_relative('../models/member')
require_relative('../models/session')
require_relative('../models/booking')

Member.delete_all
Session.delete_all
Booking.delete_all

member1 = Member.new({
  'first_name' => 'Lana',
  'last_name' => 'Marshall'
})
member1.save

member2 = Member.new({
  'first_name' => 'Sarah',
  'last_name' => 'Conelly'
})
member2.save

session1 = Session.new({
  'name' => 'Spin for the gods',
  'capacity' => 15
})
session1.save

session2 = Session.new({
  'name' => 'Krav maga',
  'capacity' => 12
})
session2.save

booking1 = Booking.new({
  'member_id' => member1.id,
  'session_id' => session1.id
})
booking1.save

booking2 = Booking.new({
  'member_id' => member2.id,
  'session_id' => session2.id
})
booking2.save
