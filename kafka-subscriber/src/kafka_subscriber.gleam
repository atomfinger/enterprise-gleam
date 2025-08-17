import gleam/io

pub fn main() {
  // Here we create a Kafka client.
  let endpoint = franz.Endpoint("localhost", 9092)
  let assert Ok(client) =
    franz.new([endpoint])
    |> franz.with_config(franz.AutoStartProducers(True))
    |> franz.start()

  // Then we create a group subscriber that commits messages after processing them.
  group_subscriber.new(
    client: client,
    group_id: "test_group",
    topics: ["test_topic"],
    message_type: message_type.Message,
    callback: fn(message: franz.KafkaMessage, _nil) {
      let assert franz.KafkaMessage(
        offset,
        key,
        value,
        timestamp_type,
        timestamp,
        [],
      ) = message
      group_subscriber.commit(cb_state)
    },
    init_callback_state: Nil,
  )
  |> group_subscriber.start()

  // Finally, we produce a message.
  producer.produce_sync(
    client: client,
    topic: "test_topic",
    partition: producer.Partition(0),
    key: <<"key">>,
    value: producer.Value(<<"value">>, []),
  )
}
