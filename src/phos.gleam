import app/router
import gleam/erlang/process
import mist
import wisp
import wisp/wisp_mist

pub fn main() {
  // This sets the logger to print INFO level logs, and other sensible
  // defaults for a web application.
  wisp.configure_logger()

  // TODO Right now we generate a stable dev "secret" key, but later we'll
  // need to set up proper secret management.
  let secret_key_base = "hello, joe!"

  // Start the Mist web server.
  let assert Ok(_) =
    wisp_mist.handler(router.handle_request, secret_key_base)
    |> mist.new
    |> mist.port(8000)
    |> mist.start_http

  // The web server runs in a new Erlang process, so we'll put this one
  // to sleep while it works concurrently.
  process.sleep_forever()
}
