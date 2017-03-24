require_relative("../db/sql_runner")



class Film

  attr_reader :id
  attr_accessor :title, :pice

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_f
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ('#{ @title }', #{@price}) RETURNING id"
    film = SqlRunner.run( sql ).first
    @id = film['id'].to_i
  end

  def delete()
    sql = "DELETE FROM films WHERE id = #{@id}"
    SqlRunner.run(sql)   
  end

  def update()
    sql = "UPDATE films 
          SET (title, price) 
          = ('#{@title}', #{@price})
          WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def tickets_sold
    sql = "SELECT f.*  FROM films f
           INNER JOIN tickets t
           ON f.id = t.film_id"
    return Film.map_items(sql).length 
  end

  def most_popular_screening()
    # sql = "SELECT COUNT(t.screening_id)FROM tickets t WHERE t.film_id = #{@id}  GROUP BY screening_id ORDER BY COUNT (t.screening_id) DESC;"

    sql = "SELECT t.screening_id, COUNT(t.screening_id) FROM tickets t WHERE t.film_id = #{@id} GROUP BY screening_id, screening_id ORDER BY COUNT (t.screening_id) DESC"
    screenings_count = SqlRunner.run(sql)
    screenings_count = screenings_count.map { |screening| screening  }.first()['screening_id']
    sql = "SELECT * FROM screenings WHERE id = #{screenings_count}"
    screening = SqlRunner.run(sql)
    screening = screening.map { |screening| Screening.new(screening) }
    binding.pry


    
    def self.find_by_id(id)
      db = PG.connect({dbname: 'bounty_hunters', host: 'localhost'})
      result = sql = "SELECT * FROM bounties WHERE id = #{id}"
      db.close
      result.map{|bounty_details| Bounty.new(bounty_details)}
      return result.first
    end

  end


  def customers()
    sql = " SELECT c.* FROM customers c
            INNER JOIN tickets t
            ON t.customer_id = c.id
            WHERE t.film_id = #{@id}" 
    return Customer.map_items(sql)
  end

  def self.all()
    sql = "SELECT * FROM films"
    return Film.map_items(sql)
  end

  def self.delete_all() 
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.map_items(sql)
    films = SqlRunner.run(sql)
    result = films.map { |film| Film.new(film)}
    return result
  end

end