require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :show_time, :film_id

  def initialize(options)
    @id = options['id'].to_i
    @show_time = options['show_time']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO screenings (show_time, film_id) VALUES ('#{ @show_time }', #{@film_id}) RETURNING id"
    screening = SqlRunner.run( sql ).first
    @id = screening['id'].to_i
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = #{@id}"
    SqlRunner.run(sql)   
  end

  def update()
    sql = "UPDATE screenings 
          SET (show_time, film_id) 
          = ('#{@show_time}', #{@film_id})
          WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  

  def self.all()
    sql = "SELECT * FROM screenings"
    return Screening.map_items(sql)
  end

  def self.delete_all() 
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def self.map_items(sql)
    screenings = SqlRunner.run(sql)
    result = screenings.map { |screening| Screening.new(screening)}
    return result
  end
end