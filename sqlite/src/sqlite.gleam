import gleam/dynamic/decode
import gleam/io
import gleam/list
import sqlight

pub fn main() {
  use connection: sqlight.Connection <- sqlight.with_connection(":memory:")
  let _ = create_table(connection)
  let _ = insert_data(connection)
  print_data(connection)
}

fn create_table(connection: sqlight.Connection) {
  let sql =
    "
CREATE TABLE historical_people (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    known_for TEXT
);
  "
  let assert Ok(Nil) = sqlight.exec(sql, connection)
}

fn insert_data(connection: sqlight.Connection) {
  let sql =
    "
INSERT INTO historical_people (name, known_for) VALUES
  ('Albert Einstein', 'Theory of Relativity'),
  ('Marie Curie', 'Research on radioactivity'),
  ('Leonardo da Vinci', 'Art and inventions'),
  ('Nelson Mandela', 'Anti-apartheid leadership'),
  ('Ada Lovelace', 'First computer programmer');
  "
  let assert Ok(Nil) = sqlight.exec(sql, connection)
}

fn print_data(connection: sqlight.Connection) {
  let sql = "SELECT * FROM historical_people;"
  let decoder = {
    use id <- decode.field(0, decode.int)
    use name <- decode.field(1, decode.string)
    use known_for <- decode.field(2, decode.string)
    decode.success(KnownPerson(id:, name:, known_for:))
  }
  let assert Ok(data) =
    sqlight.query(sql, on: connection, expecting: decoder, with: [])

  io.println("_______________________________________________________")
  io.println("\nThere's some famous historical people in this database!\n")
  list.each(data, fn(person) {
    io.println(person.name <> " is known for " <> person.known_for)
  })
  io.println("_______________________________________________________")
}

type KnownPerson {
  KnownPerson(id: Int, name: String, known_for: String)
}
