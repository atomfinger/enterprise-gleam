# scheduled_job

## Description

This is a very basic example of job scheduling which executes a simple printout
once every minute. It uses [clockwork](https://github.com/renatillas/clockwork)
for cron, and
[clockwork_scheduling](https://github.com/renatillas/clockwork_schedule) for the
actual scheduling.

The process can (and should) be made more robust by utilizing [supervised scheduling](https://github.com/renatillas/clockwork_schedule).

## Development

```sh
gleam run   # Run the project and then wait
```
