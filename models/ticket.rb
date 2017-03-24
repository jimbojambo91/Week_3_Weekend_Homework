require_relative("../db/sql_runner")
require_relative('customer')
require_relative('film')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES (#{ @customer_id }, #{film_id}) RETURNING id"
    ticket = SqlRunner.run( sql ).first
    @id = ticket['id'].to_i
    
    sql = "SELECT f.price FROM films f 
          WHERE f.id = #{@film_id}"
    ticket_price = SqlRunner.run(sql).first()['price'].to_f
    sql = "SELECT c.funds, c.id FROM customers c
          WHERE c.id = #{@customer_id}"
    customer_funds = SqlRunner.run(sql).first()['funds'].to_f
    customer_id = SqlRunner.run(sql).first()['id'].to_i
    customer_funds -= ticket_price
    sql = "UPDATE customers 
          SET (funds) 
          = (#{customer_funds})
          WHERE id = #{customer_id}"
    SqlRunner.run(sql)

    # customer.funds = customer_funds
    # Customer.update
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = #{@id}"
    SqlRunner.run(sql)   
  end

  def update()
    sql = "UPDATE tickets 
          SET (customer_id, film_id) 
          = (#{@customer_id}, #{@film_id})
          WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    return Ticket.map_items(sql)
  end

  def self.delete_all() 
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.map_items(sql)
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| Ticket.new(ticket)}
    return result
  end

end