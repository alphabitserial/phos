import app/web
import gleam/http.{Get, Post}
import gleam/string_builder.{type StringBuilder}
import lustre/element
import lustre/element/html.{html}
import wisp.{type Request, type Response}

/// Application entry point
pub fn handle_request(req: Request) -> Response {
  // Apply the middleware stack to all requests/responses.
  use _req <- web.middleware(req)

  case wisp.path_segments(req) {
    [] -> index(req)
    ["greet", name] -> greet(req, name)
    _ -> wisp.not_found()
  }
}

fn index(req: Request) -> Response {
  // This page can only be accessed via GET request.
  // Return a 405 Method Not Allowed for all other methods.
  use <- wisp.require_method(req, Get)

  let html =
    html([], [
      html.head([], [html.title([], "Greetings!")]),
      html.body([], [html.h1([], [element.text("Hello from Wisp & Lustre!")])]),
    ])
    |> element.to_document_string_builder

  wisp.ok()
  |> wisp.html_body(html)
}

fn greet(req: Request, name: String) -> Response {
  use <- wisp.require_method(req, Get)

  let html =
    html([], [
      html.head([], [html.title([], "Hi " <> name <> "!")]),
      html.body([], [html.h1([], [element.text("Hello " <> name <> "!")])]),
    ])
    |> element.to_document_string_builder

  wisp.ok()
  |> wisp.html_body(html)
}
