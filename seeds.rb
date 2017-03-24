require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/ticket' )

require( 'pry-byebug' )

# Ticket.delete_all()
Customer.delete_all()
# Film.delete_all()

customer1 = Customer.new({ 'name' => 'James', 'funds' => 25.00})
customer1.save()

binding.pry
nil
