import app/web
import gleam/string_builder
import wisp.{type Request, type Response}

/// Application entry point
pub fn handle_request(req: Request) -> Response {
  // Apply the middleware stack to all requests/responses.
  use _req <- web.middleware(req)

  // Later we'll use templates, but for now a string will do.
  let body = string_builder.from_string("<h1>Hello, Joe!</h1>")

  // Return a 200 OK response with the body and a content-type of HTML
  wisp.html_response(body, 200)
}
