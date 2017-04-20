# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :revex,
  url: "https://api-sandbox.rev.com/"

import_config "#{Mix.env}.exs"
