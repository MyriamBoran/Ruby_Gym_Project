require 'minitest/autorun'
require 'minitest/rg'
require_relative('../booking')
require_relative('../member')
require_relative('../session')

class MemberTest < MiniTest::Test

  def test_save_member
    member = Member.new({
      'first_name' => 'Lana',
      'last_name' => 'Marshall'
    })
    member.save

   assert(member.id != nil)
  end

  def test_sessions
    member = Member.new({
      'first_name' => 'Connie',
      'last_name' => 'Lewis'
    })
    member.save

    session1 = Session.new({
      'name' => 'Pilates',
      'capacity' => 12
    })
    session1.save

    session2 = Session.new({
      'name' => 'Spin for the gods',
      'capacity' => 15
    })
    session2.save

    Booking.new({
      'member_id' => member.id,
      'session_id' => session2.id
    }).save

    Booking.new({
      'member_id' => member.id,
      'session_id' => session1.id
    }).save

    session_ids = member.sessions.map {|session| session.id}

    assert_equal(session_ids.sort, [session1.id, session2.id])
  end
end
