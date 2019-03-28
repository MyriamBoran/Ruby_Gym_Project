require 'minitest/autorun'
require 'minitest/rg'
require_relative('../booking')
require_relative('../member')
require_relative('../session')

class BookingTest < MiniTest::Test

  def setup
    @member = Member.new({
      'first_name' => 'Lana',
      'last_name' => 'Marshall'
    })
    @member.save

    @session = Session.new({
      'name' => 'Spin for the gods',
      'capacity' => 15
    })
    @session.save
  end

  def test_save_booking
    booking = Booking.new({
      'member_id' => @member.id,
      'session_id' => @session.id
    })
    booking.save

    assert(booking.id != nil)
  end

  def test_member
    booking = Booking.new({
      'member_id' => @member.id,
      'session_id' => @session.id
    })
    booking.save

    assert_equal(booking.member.id, @member.id)
  end

  def test_session
    booking = Booking.new({
      'member_id' => @member.id,
      'session_id' => @session.id
    })
    booking.save

   assert_equal(booking.session.id, @session.id)
  end
end
