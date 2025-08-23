import gleam/dynamic/decode
import gleam/erlang/process
import gleam/io
import gleam/json
import gleam/list
import gleam/option
import gleam/otp/static_supervisor as supervisor
import valkyrie

pub fn main() {
  let pool_name = process.new_name("connection_pool")

  let valkyrie_child_spec =
    valkyrie.default_config()
    |> valkyrie.supervised_pool(
      size: 10,
      name: option.Some(pool_name),
      timeout: 1000,
    )
  let assert Ok(_started) =
    supervisor.new(supervisor.OneForOne)
    |> supervisor.add(valkyrie_child_spec)
    |> supervisor.start
  let conn: valkyrie.Connection = valkyrie.named_connection(pool_name)
  let _ = set_historical_people(conn)
  read_known_people(conn)
}

fn read_known_people(connection: valkyrie.Connection) {
  let assert Ok(result) = valkyrie.get(connection, "known_people", 1000)
  let person_decoder = {
    use name <- decode.field("name", decode.string)
    use known_for <- decode.field("known_for", decode.string)
    decode.success(KnownPerson(name:, known_for:))
  }
  let decoder = {
    decode.list(person_decoder)
  }
  let assert Ok(known_people) = json.parse(result, decoder)
  io.println("_______________________________________________________")
  io.println("\nThere's some famous historical people in this database!\n")
  list.each(known_people, fn(person) {
    io.println(person.name <> " is known for " <> person.known_for)
  })
  io.println("_______________________________________________________")
}

fn set_historical_people(connection: valkyrie.Connection) {
  let known_people_json =
    [
      KnownPerson("Albert Einstein", "Theory of Relativity"),
      KnownPerson("Marie Curie", "Research on radioactivity"),
      KnownPerson("Leonardo da Vinci", "Art and inventions"),
      KnownPerson("Nelson Mandela", "Anti-apartheid leadership"),
      KnownPerson("Ada Lovelace", "First computer programmer"),
    ]
    |> list.map(fn(person) {
      json.object([
        #("name", json.string(person.name)),
        #("known_for", json.string(person.known_for)),
      ])
    })
    |> json.preprocessed_array()
    |> json.to_string()

  let assert Ok(_) =
    valkyrie.set(
      connection,
      "known_people",
      known_people_json,
      option.None,
      1000,
    )
}

type KnownPerson {
  KnownPerson(name: String, known_for: String)
}
