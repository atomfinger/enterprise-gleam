import gleam/bool
import gleam/dict
import gleam/dynamic/decode
import gleam/float
import gleam/http
import gleam/http/response
import gleam/int
import gleam/json
import gleam/option.{type Option, None}
import gleam/result
import oas/generator/utils
import petstore/schema

pub fn delete_user_request(base, username) {
  let method = http.Delete
  let path = "/user/" <> username
  let query = []
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
}

pub fn delete_user_response(response) {
  let response.Response(status:, ..) = response
  case status {
    200 -> Ok(Nil) |> Ok
    _ -> Error(Nil) |> Ok
  }
}

pub fn update_user_request(base, username, data) {
  let method = http.Put
  let path = "/user/" <> username
  let query = []
  let body = utils.json_to_bits(schema.user_encode(data))
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
  |> utils.set_body("application/json", body)
}

pub fn update_user_response(response) {
  let response.Response(status:, ..) = response
  case status {
    200 -> Ok(Nil) |> Ok
    _ -> Error(Nil) |> Ok
  }
}

pub fn get_user_by_name_request(base, username) {
  let method = http.Get
  let path = "/user/" <> username
  let query = []
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
}

pub fn get_user_by_name_response(response) {
  let response.Response(status:, body:, ..) = response
  case status {
    200 -> json.parse_bits(body, schema.user_decoder()) |> result.map(Ok)
    _ -> Error(Nil) |> Ok
  }
}

pub fn logout_user_request(base) {
  let method = http.Get
  let path = "/user/logout"
  let query = []
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
}

pub fn logout_user_response(response) {
  let response.Response(status:, ..) = response
  case status {
    200 -> Ok(Nil) |> Ok
    _ -> Error(Nil) |> Ok
  }
}

pub fn login_user_request(base, username username, password password) {
  let method = http.Get
  let path = "/user/login"
  let query = [#("username", username), #("password", password)]
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
}

pub fn login_user_response(response) {
  let response.Response(status:, body:, ..) = response
  case status {
    200 -> json.parse_bits(body, decode.string) |> result.map(Ok)
    _ -> Error(Nil) |> Ok
  }
}

pub fn create_users_with_list_input_request(base, data) {
  let method = http.Post
  let path = "/user/createWithList"
  let query = []
  let body = utils.json_to_bits(json.array(data, schema.user_encode))
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
  |> utils.set_body("application/json", body)
}

pub fn create_users_with_list_input_response(response) {
  let response.Response(status:, body:, ..) = response
  case status {
    200 -> json.parse_bits(body, schema.user_decoder()) |> result.map(Ok)
    _ -> Error(Nil) |> Ok
  }
}

pub fn create_user_request(base, data) {
  let method = http.Post
  let path = "/user"
  let query = []
  let body = utils.json_to_bits(schema.user_encode(data))
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
  |> utils.set_body("application/json", body)
}

pub fn create_user_response(response) {
  let response.Response(status:, body:, ..) = response
  case status {
    200 -> json.parse_bits(body, schema.user_decoder()) |> result.map(Ok)
    _ -> Error(Nil) |> Ok
  }
}

pub fn delete_order_request(base, order_id) {
  let method = http.Delete
  let path = "/store/order/" <> int.to_string(order_id)
  let query = []
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
}

pub fn delete_order_response(response) {
  let response.Response(status:, ..) = response
  case status {
    200 -> Ok(Nil) |> Ok
    _ -> Error(Nil) |> Ok
  }
}

pub fn get_order_by_id_request(base, order_id) {
  let method = http.Get
  let path = "/store/order/" <> int.to_string(order_id)
  let query = []
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
}

pub fn get_order_by_id_response(response) {
  let response.Response(status:, body:, ..) = response
  case status {
    200 -> json.parse_bits(body, schema.order_decoder()) |> result.map(Ok)
    _ -> Error(Nil) |> Ok
  }
}

pub fn place_order_request(base, data) {
  let method = http.Post
  let path = "/store/order"
  let query = []
  let body = utils.json_to_bits(schema.order_encode(data))
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
  |> utils.set_body("application/json", body)
}

pub fn place_order_response(response) {
  let response.Response(status:, body:, ..) = response
  case status {
    200 -> json.parse_bits(body, schema.order_decoder()) |> result.map(Ok)
    _ -> Error(Nil) |> Ok
  }
}

pub fn get_inventory_request(base) {
  let method = http.Get
  let path = "/store/inventory"
  let query = []
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
}

pub fn get_inventory_response(response) {
  let response.Response(status:, body:, ..) = response
  case status {
    200 ->
      json.parse_bits(body, decode.dict(decode.string, decode.int))
      |> result.map(Ok)
    _ -> Error(Nil) |> Ok
  }
}

pub fn upload_file_request(
  base,
  pet_id,
  additional_metadata additional_metadata,
) {
  let method = http.Post
  let path = "/pet/" <> int.to_string(pet_id) <> "/uploadImage"
  let query = [#("additional_metadata", additional_metadata)]
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
}

pub fn upload_file_response(response) {
  let response.Response(status:, body:, ..) = response
  case status {
    200 ->
      json.parse_bits(body, schema.api_response_decoder()) |> result.map(Ok)
    _ -> Error(Nil) |> Ok
  }
}

pub fn delete_pet_request(base, pet_id) {
  let method = http.Delete
  let path = "/pet/" <> int.to_string(pet_id)
  let query = []
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
}

pub fn delete_pet_response(response) {
  let response.Response(status:, ..) = response
  case status {
    200 -> Ok(Nil) |> Ok
    _ -> Error(Nil) |> Ok
  }
}

pub fn update_pet_with_form_request(base, pet_id, name name, status status) {
  let method = http.Post
  let path = "/pet/" <> int.to_string(pet_id)
  let query = [#("name", name), #("status", status)]
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
}

pub fn update_pet_with_form_response(response) {
  let response.Response(status:, body:, ..) = response
  case status {
    200 -> json.parse_bits(body, schema.pet_decoder()) |> result.map(Ok)
    _ -> Error(Nil) |> Ok
  }
}

pub fn get_pet_by_id_request(base, pet_id) {
  let method = http.Get
  let path = "/pet/" <> int.to_string(pet_id)
  let query = []
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
}

pub fn get_pet_by_id_response(response) {
  let response.Response(status:, body:, ..) = response
  case status {
    200 -> json.parse_bits(body, schema.pet_decoder()) |> result.map(Ok)
    _ -> Error(Nil) |> Ok
  }
}

pub fn find_pets_by_tags_request(base, tags tags) {
  let method = http.Get
  let path = "/pet/findByTags"
  let query = [
    #(
      "tags",
      option.map(tags, fn(_) { panic as "query parameter is not supported" }),
    ),
  ]
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
}

pub fn find_pets_by_tags_response(response) {
  let response.Response(status:, body:, ..) = response
  case status {
    200 ->
      json.parse_bits(body, decode.list(schema.pet_decoder()))
      |> result.map(Ok)
    _ -> Error(Nil) |> Ok
  }
}

pub fn find_pets_by_status_request(base, status status) {
  let method = http.Get
  let path = "/pet/findByStatus"
  let query = [#("status", status)]
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
}

pub fn find_pets_by_status_response(response) {
  let response.Response(status:, body:, ..) = response
  case status {
    200 ->
      json.parse_bits(body, decode.list(schema.pet_decoder()))
      |> result.map(Ok)
    _ -> Error(Nil) |> Ok
  }
}

pub fn add_pet_request(base, data) {
  let method = http.Post
  let path = "/pet"
  let query = []
  let body = utils.json_to_bits(schema.pet_encode(data))
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
  |> utils.set_body("application/json", body)
}

pub fn add_pet_response(response) {
  let response.Response(status:, body:, ..) = response
  case status {
    200 -> json.parse_bits(body, schema.pet_decoder()) |> result.map(Ok)
    _ -> Error(Nil) |> Ok
  }
}

pub fn update_pet_request(base, data) {
  let method = http.Put
  let path = "/pet"
  let query = []
  let body = utils.json_to_bits(schema.pet_encode(data))
  base
  |> utils.set_method(method)
  |> utils.append_path(path)
  |> utils.set_query(query)
  |> utils.set_body("application/json", body)
}

pub fn update_pet_response(response) {
  let response.Response(status:, body:, ..) = response
  case status {
    200 -> json.parse_bits(body, schema.pet_decoder()) |> result.map(Ok)
    _ -> Error(Nil) |> Ok
  }
}
