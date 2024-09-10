import wisp

/// This middleware stack is applied to all requests/responses.
///
/// Middleware wrap each other, so the request travels through the stack
/// from top to bottom until it reaches the request handler, at which point
/// the response travels back up through the stack.
///
/// The middleware used here are the ones that are suitable for use in
/// your typical web application.
pub fn middleware(
  req: wisp.Request,
  handle_request: fn(wisp.Request) -> wisp.Response,
) -> wisp.Response {
  // Permit browsers to simulate methods other than GET and POST
  // using the `_method` query parameter.
  let req = wisp.method_override(req)

  // Log information about the request/response.
  use <- wisp.log_request(req)

  // Return a default 500 response (internal server error) if the
  // request handler crashes.
  use <- wisp.rescue_crashes

  // Rewrite HEAD requests to GET requests and return an empty body.
  use req <- wisp.handle_head(req)

  // Pass the request off to the handler
  handle_request(req)
}
