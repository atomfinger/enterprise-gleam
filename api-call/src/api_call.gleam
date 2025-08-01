import gleam/dynamic/decode
import gleam/http/request
import gleam/httpc
import gleam/io
import gleam/json
import gleam/option
import gleam/result
import gleam/uri

pub fn main() {
  case get_joke() {
    Ok(joke) -> io.print(joke)
    Error(_) -> io.println("I COULDN'T MAKE JOKE 🥲")
  }
}

fn get_joke() -> Result(String, Nil) {
  use url <- result.try(uri.parse("https://v2.jokeapi.dev/joke/Any"))
  use req <- result.try(request.from_uri(url))
  use response <- result.try(result.replace_error(httpc.send(req), Nil))
  use joke: Joke <- result.try(result.replace_error(
    json.parse(from: response.body, using: decoder()),
    Nil,
  ))
  case joke.joke_type {
    "single" -> option.unwrap(joke.joke, "") |> Ok()
    "twopart" ->
      {
        option.unwrap(joke.setup, "")
        <> "\n"
        <> option.unwrap(joke.delivery, "")
      }
      |> Ok()
    _ -> Error(Nil)
  }
}

fn decoder() -> decode.Decoder(Joke) {
  let decoder = {
    use has_error <- decode.field("error", decode.bool)
    use category <- decode.field("category", decode.string)
    use joke_type <- decode.field("type", decode.string)
    use setup <- decode.optional_field(
      "setup",
      option.None,
      decode.optional(decode.string),
    )
    use delivery <- decode.optional_field(
      "delivery",
      option.None,
      decode.optional(decode.string),
    )
    use joke <- decode.optional_field(
      "joke",
      option.None,
      decode.optional(decode.string),
    )

    decode.success(Joke(has_error, category, joke_type, setup, delivery, joke))
  }
  decoder
}

type Joke {
  Joke(
    has_error: Bool,
    category: String,
    joke_type: String,
    setup: option.Option(String),
    delivery: option.Option(String),
    joke: option.Option(String),
  )
}
