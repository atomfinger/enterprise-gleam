import gleam/http/request

fn base_request(token: a) -> request.Request(String) {
  request.new()
}
// GENERATED -------------
