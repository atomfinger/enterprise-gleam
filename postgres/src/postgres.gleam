import gleam/dynamic/decode
import gleam/erlang/process
import gleam/io
import gleam/list
import gleam/option.{Some}
import gleam/otp/actor
import pog

pub fn main() {
  let db: actor.Started(pog.Connection) = start_default()
  create_table(db)
  insert_data(db)
  read_data(db)
}

fn create_table(db: actor.Started(pog.Connection)) {
  let create_table_query =
    "
 CREATE TABLE IF NOT EXISTS historical_people (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    known_for VARCHAR(255)
);
  "
  //TRUNCATE TABLE historical_people RESTART IDENTITY;
  let assert Ok(_) = pog.query(create_table_query) |> pog.execute(db.data)
  io.println("Table created...")

  let empty_table_query = "TRUNCATE TABLE historical_people RESTART IDENTITY;"

  let assert Ok(_) = pog.query(empty_table_query) |> pog.execute(db.data)
}

fn insert_data(db: actor.Started(pog.Connection)) {
  let query =
    "
INSERT INTO historical_people (name, known_for) VALUES
  ('Albert Einstein', 'Theory of Relativity'),
  ('Marie Curie', 'Research on radioactivity'),
  ('Leonardo da Vinci', 'Art and inventions'),
  ('Nelson Mandela', 'Anti-apartheid leadership'),
  ('Ada Lovelace', 'First computer programmer');
 "
  let assert Ok(_) = pog.query(query) |> pog.execute(db.data)
  io.println("Data inserted...")
}

fn read_data(db: actor.Started(pog.Connection)) {
  let query = "SELECT * FROM historical_people;"
  let decoder = {
    use id <- decode.field(0, decode.int)
    use name <- decode.field(1, decode.string)
    use known_for <- decode.field(2, decode.string)
    decode.success(KnownPerson(id:, name:, known_for:))
  }
  let assert Ok(data) =
    pog.query(query) |> pog.returning(decoder) |> pog.execute(db.data)
  io.println("_______________________________________________________")
  io.println("\nThere's some famous historical people in this database!\n")
  list.each(data.rows, fn(person) {
    io.println(person.name <> " is known for " <> person.known_for)
  })
  io.println("_______________________________________________________")
}

type KnownPerson {
  KnownPerson(id: Int, name: String, known_for: String)
}

fn start_default() -> actor.Started(pog.Connection) {
  let assert Ok(started) =
    process.new_name("pog_connection")
    |> default_config
    |> pog.start
  started
}

fn default_config(name) {
  pog.Config(
    ..pog.default_config(name),
    database: "postgres",
    user: "postgres",
    password: Some("postgres"),
    pool_size: 1,
    port: 5432,
    host: "127.0.0.1",
  )
}
