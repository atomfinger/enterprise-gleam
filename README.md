# Enterprise Gleam (TODO: Come up with better name)

The goal of this repo is to uncover what the Gleam ecosystem 
is prepared for in terms of integrations. Companies don't
want to reinvent the wheel, and they often have pre-existing
infrastructure and tools which a new system will be required to use.

## Symbols

- ✅: It is fully supported, no problems.
- 🤏🏻: It can be supported, but requires a lot of faffing about and
  doesn't feel good. Often feels hack-y and forced.
- ❌: No support / you'll have to build support yourself
- 🚧: WIP / Yet to be looked into

## Web Services

- ✅ Calling JSON API
- ✅ Hosting JSON Web API: TODO - add example
- ❌ Hosting gRPC service: No out-of-box lib for this. Would require writing a
  full wrapper around existing tools or building your own on top of a HTTP library.
- 🚧 Calling gRPC service (Status: No known libs)
- 🚧 Calling Graphql APIs (lib: [gleamql](https://github.com/cobbinma/gleamql))
  TODO: Add example
- ❌ Hosting Graphql service (Status: No known libs)
- 🤏🏻 Calling SOAP services (Status: No known libs)
- 🤏🏻 Hosting SOAP web service (Status: No known libs)

## Code generation

- 🚧 Generate OpenAPI clients (Struggling atm)
- 🚧 Generate OpenAPI server
- 🚧 Generate SOAP clients (Status: No known libs)
- 🚧 Generating SOAP server (Status: No known libs)
- 🚧 Generate types from Avro (Status: No known libs)
- 🚧 Generate types from protobuf (lib: [acrostic](https://github.com/julywind168/acrostic),
  a little outdated)

## Messaging/Event queue

- ✅ Kafka
- 🚧 AMQP (RabbitMQ, Azure Service Bus)
  (lib: [Carrotte](https://github.com/renatillas/carotte)?)
- 🚧 MQTT (Eclipse Mosquitto)
- 🚧 AWS SQS
- 🚧 Google Pub/Sub

## Databases

Note: The selection of databases is based on top 10 used databases by
professional developers, outlined in [StackOverflow's developer survey (2025)](https://survey.stackoverflow.co/2025/technology#1-databases).

- ✅ Postgres support
- 🚧 MSSQL suport (Status: No known libs)
- 🚧 Oracle DB support (Status: No known libs)
- ✅ Redis support (lib: [valkyrie](https://github.com/Pevensie/valkyrie))
- 🚧 MongoDB support (Status: Abandoned?)
- 🚧 MySQL support (Status: [Shork](https://github.com/ninanomenon/shork), need
  to test. GPL license might be worth mentioning)
- ✅ SQLite support
- 🚧 Dynamodb support (Status: No known libs)
- 🚧 Elasticsearch support (Status: No known libs)
- 🚧 MariaDB support (Shork again)

## Security

- 🚧 JWT handling (Status: No known libs)
- 🚧 TLS/SSL utilities (Status: No known libs)
- 🚧 Cryptographic functions (hashing, HMAC, AES, RSA, bcrypt/argon2)
- 🚧 mTLS support (Status: No known libs)
- 🚧 OAuth (Lib: [Spotless](https://github.com/CrowdHailer/gleam_spotless))

## Task Scheduling / Background Jobs

- 🚧 Simple task scheduling (cron-like, periodic tasks) 
- 🚧 Background job execution (delayed/retryable jobs)

## Observability

- 🚧 Structured logging
- 🚧 OpenTelemetry (Status: [glotel](https://github.com/skinkade/glotel),
  outdated? Abandoned?)

## Testing

- ✅ Unit testing framework (Gleeunit, no examples needed)
- 🚧 Snapshot testing (lib: [birdie](https://github.com/giacomocavalieri/birdie))
  TODO: Add example
- 🚧 Mocking/stubbing libraries
  (lib: [mokth](https://github.com/bondiano/mockth), outdated)
- 🚧 Integration testing support (Status: No known libs)
- 🚧 Property-based testing
  (lib [gleam_qcheck](https://github.com/mooreryan/gleam_qcheck), a little
  outdated, but might be okay?)
- 🚧 Test coverage tools (Status: No known libs)
- 🚧 Mutation testing
- 🚧 TestContainers / containerized test support (Status: No known libs)
- 🚧 Contract testing (Status: No known libs)

## Misc

- 🚧 S3 support
