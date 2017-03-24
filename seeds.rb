require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/ticket' )
require_relative( 'models/screening' )

require( 'pry-byebug' )

Ticket.delete_all()
Customer.delete_all()
Screening.delete_all()
Film.delete_all()

customer1 = Customer.new({ 'name' => 'James', 'funds' => 25.00})
customer2 = Customer.new({ 'name' => 'Andrew', 'funds' => 10.00})
customer3 = Customer.new({ 'name' => 'Caroline', 'funds' => 50.00})
customer4 = Customer.new({ 'name' => 'Michael', 'funds' => 30.00})
customer5 = Customer.new({ 'name' => 'Bill', 'funds' => 100.00})
customer1.save()
customer2.save()
customer3.save()
customer4.save()
customer5.save()

film1 = Film.new({'title' => 'Die Hard', 'price' => 10.00})
film2 = Film.new({'title' => 'Die Hard 2', 'price' => 10.00})
film3 = Film.new({'title' => 'Die Hard with a Vengeance', 'price' => 10.00})
film4 = Film.new({'title' => 'Live Free or Die Hard', 'price' => 10.00})
film5 = Film.new({'title' => 'A Good Day to Die Hard', 'price' => 10.00})


film1.save()
film2.save()
film3.save()
film4.save()
film5.save()

screening1 = Screening.new({'show_time' => '12:00:00', 'film_id' => film1.id})
screening2 = Screening.new({'show_time' => '16:00:00', 'film_id' => film2.id})
screening3 = Screening.new({'show_time' => '19:30:00', 'film_id' => film1.id})

screening1.save()
screening2.save()
screening3.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id, 'screening_id' => screening1.id})
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id, 'screening_id' => screening2.id})
ticket3 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id, 'screening_id' => screening2.id})
ticket4 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film1.id, 'screening_id' => screening2.id})
ticket5 = Ticket.new({'customer_id' => customer5.id, 'film_id' => film2.id, 'screening_id' => screening3.id})
ticket6 = Ticket.new({'customer_id' => customer5.id, 'film_id' => film2.id, 'screening_id' => screening3.id})
ticket7 = Ticket.new({'customer_id' => customer5.id, 'film_id' => film2.id, 'screening_id' => screening3.id})
ticket8 = Ticket.new({'customer_id' => customer5.id, 'film_id' => film2.id, 'screening_id' => screening3.id})
ticket9 = Ticket.new({'customer_id' => customer5.id, 'film_id' => film1.id, 'screening_id' => screening3.id})
ticket10 = Ticket.new({'customer_id' => customer5.id, 'film_id' => film1.id, 'screening_id' => screening3.id})
ticket11 = Ticket.new({'customer_id' => customer5.id, 'film_id' => film1.id, 'screening_id' => screening3.id})

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()
ticket6.save()
ticket7.save()
ticket8.save()
ticket9.save()
ticket10.save()
ticket11.save()

# Screening.most_popular_screening(film1)
film2.most_popular_screening()




binding.pry
nil
