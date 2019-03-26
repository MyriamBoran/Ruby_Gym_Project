require_relative('../db/sql_runner.rb')

class Member

  attr_reader :first_name, :last_name, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  #CRUD

  def save
    sql = 'INSERT INTO members (first_name, last_name) VALUES ($1, $2) RETURNING id'
    values = [@first_name, @last_name]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def self.all
    sql = 'SELECT * FROM members'
    return SqlRunner.run(sql).map {|member| Member.new(member)}
  end

  def self.find(id)
    sql = 'SELECT * FROM members WHERE id = $1'
    values = [id]
    member = SqlRunner.run(sql, values).first
    return Member.new(member) if member != nil
  end

  def update
    sql = 'UPDATE members SET (first_name, last_name) = ($1, $2) WHERE id = $3'
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = 'DELETE FROM members WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = 'DELETE FROM members'
    SqlRunner.run(sql)
  end

  def sessions
    sql = "SELECT sessions.* FROM sessions JOIN bookings ON bookings.session_id = sessions.id WHERE member_id = $1"
    values = [@id]
    return SqlRunner.run( sql, values ).map {|session| Session.new(session)}
  end
end
