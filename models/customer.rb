require_relative("../db/sql_runner")


class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_f
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ('#{ @name }', #{funds}) RETURNING id"
    customer = SqlRunner.run( sql ).first
    @id = customer['id'].to_i
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = #{@id}"
    SqlRunner.run(sql)   
  end

  def update()
    sql = "UPDATE customers 
          SET (name, funds) 
          = ('#{@name}', #{@funds})
          WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def films()
    sql = " SELECT f.* FROM films f
            INNER JOIN tickets t
            ON t.film_id = f.id
            WHERE t.customer_id = #{@id}" 
    return Film.map_items(sql)
  end

  def tickets_bought()
    return films.length    
  end

  def self.all()
    sql = "SELECT * FROM customers"
    return Customer.map_items(sql)
  end

  def self.delete_all() 
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.map_items(sql)
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new(customer)}
    return result
  end

end