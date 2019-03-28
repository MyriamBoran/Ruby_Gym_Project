require 'minitest/autorun'
require 'minitest/rg'
require_relative('../booking')
require_relative('../member')
require_relative('../session')

class SessionTest < MiniTest::Test

  def test_save_session
    session = Session.new({
      'name' => 'Spin for the gods',
      'capacity' => 15
    })
    session.save

   assert(session.id != nil)
  end

  def test_attendance
    session = Session.new({
      'name' => 'Spin for the gods',
      'capacity' => 15
    })
    session.save

    member1 = Member.new({
      'first_name' => 'Connie',
      'last_name' => 'Lewis'
    })
    member1.save

    member2 = Member.new({
      'first_name' => 'Lara',
      'last_name' => 'Croft'
    })
    member2.save

    Booking.new({
      'member_id' => member1.id,
      'session_id' => session.id
    }).save

    Booking.new({
      'member_id' => member2.id,
      'session_id' => session.id
    }).save

    attendance_ids = session.attendance.map {|member| member.id}

    assert_equal(attendance_ids.sort, [member1.id, member2.id])
  end
end
