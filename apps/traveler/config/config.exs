# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :traveler,
  ecto_repos: [Traveler.Repo]

# Configures the endpoint
config :traveler, TravelerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xu3EI8LDTqS03DHRANt3WvVdjgi4z8x2yquI95+M6ndO0xxVL6f7HUj+k8nA/ya2",
  render_errors: [view: TravelerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Traveler.PubSub,
  live_view: [signing_salt: "XnqIY1Vg"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
