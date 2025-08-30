import clockwork
import clockwork_schedule
import gleam/erlang/process
import gleam/io

pub fn main() -> Nil {
  let assert Ok(cron) = clockwork.from_string("* * * * *")

  let job = fn() { io.println("Task ran!") }

  let scheduler = clockwork_schedule.new("important_job", cron, job)
  let assert Ok(_schedule) = clockwork_schedule.start(scheduler)

  process.sleep_forever()
}
