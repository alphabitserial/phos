import app/web
import gleam/string_builder.{type StringBuilder}
import lustre/element
import lustre/element/html.{html}
import wisp.{type Request, type Response}

/// Application entry point
pub fn handle_request(req: Request) -> Response {
  // Apply the middleware stack to all requests/responses.
  use _req <- web.middleware(req)

  // Right now, let's generate the same template no matter what
  // the user requests.
  let body = index()

  // Return a 200 OK response with the body and a content-type of HTML
  wisp.html_response(body, 200)
}

fn index() -> StringBuilder {
  html([], [
    html.head([], [html.title([], "Greetings!")]),
    html.body([], [html.h1([], [element.text("Hello from Wisp & Lustre!")])]),
  ])
  |> element.to_document_string_builder
}
