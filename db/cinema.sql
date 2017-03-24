DROP TABLE tickets;
DROP TABLE screenings;
DROP TABLE customers;
DROP TABLE films;


CREATE TABLE customers(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds FLOAT
);

CREATE TABLE films(
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price FLOAT
);

CREATE TABLE tickets(
  id SERIAL4 PRIMARY KEY,
  customer_id INT2 REFERENCES customers(id),
  film_id INT2 REFERENCES films(id)
);

CREATE TABLE screenings(
  id SERIAL4 PRIMARY KEY,
  show_time TIME,
  film_id INT2 REFERENCES films(id)
);
