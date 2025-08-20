import franz
import franz/message_type
import franz/partitions
import franz/producer
import franz/topic_subscriber
import gleam/bit_array
import gleam/erlang/process
import gleam/io

pub fn main() {
  let endpoint = franz.Endpoint("localhost", 9092)
  let client: franz.FranzClient = {
    case
      franz.new([endpoint])
      |> franz.with_config(franz.AutoStartProducers(True))
      |> franz.start()
    {
      Ok(client) -> client
      _ -> panic
    }
  }
  let _ = start_subscriber(client)
  let _ = produce_message(client)

  process.sleep_forever()
}

fn produce_message(client: franz.FranzClient) {
  producer.produce_sync(
    client: client,
    topic: "test_topic",
    partition: producer.Partition(0),
    key: <<"my_key">>,
    value: producer.Value(<<"This is a very cool message">>, []),
  )
}

fn start_subscriber(client: franz.FranzClient) {
  topic_subscriber.new(
    client: client,
    topic: "test_topic",
    partitions: partitions.Partitions([0]),
    message_type: message_type.Message,
    callback: fn(_partition, message, cb_state) {
      io.println("Message recieved")
      let assert franz.KafkaMessage(
        _offset,
        key,
        value,
        franz.Create,
        _timestamp,
        [],
      ) = message
      let assert Ok(parsed_key) = bit_array.to_string(key)
      let assert Ok(parsed_value) = bit_array.to_string(value)
      io.println(
        "Got message with "
        <> parsed_key
        <> ", with the message: "
        <> parsed_value,
      )
      topic_subscriber.ack(cb_state)
    },
    init_callback_state: 0,
  )
  // |> topic_subscriber.with_commited_offset(partition: 0, offset: 0)
  |> topic_subscriber.start()
}
