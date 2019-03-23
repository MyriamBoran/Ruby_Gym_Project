DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS sessions;


CREATE TABLE members(
  id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE sessions(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  capacity INT4
);

CREATE TABLE bookings(
  id SERIAL8 PRIMARY KEY,
  member_id INT2 REFERENCES members(id) ON DELETE CASCADE,
  session_id INT2 REFERENCES sessions(id) ON DELETE CASCADE
);
