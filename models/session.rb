require_relative('../db/sql_runner.rb')

class Session

  attr_reader :name, :capacity, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @capacity = options['capacity']
  end

  #CRUD

  def save
    sql = 'INSERT INTO sessions (name, capacity) VALUES ($1, $2) RETURNING id'
    values = [@name, @capacity]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def self.all
    sql = 'SELECT * FROM sessions'
    return SqlRunner.run(sql).map {|session| Session.new(session)}
  end

  def self.find(id)
    sql = 'SELECT * FROM sessions WHERE id = $1'
    values = [id]
    session = SqlRunner.run(sql, values).first
    return Session.new(session) if session != nil
  end

  def update
    sql = 'UPDATE sessions SET (name, capacity) = ($1, $2) WHERE id = $3'
    values = [@name, @capacity, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = 'DELETE FROM sessions WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = 'DELETE FROM sessions'
    SqlRunner.run(sql)
  end
end
