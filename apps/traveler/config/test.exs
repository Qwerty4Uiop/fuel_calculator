use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :traveler, Traveler.Repo,
  username: System.get_env("DB_ENV_POSTGRES_USER") || "postgres",
  password: System.get_env("DB_ENV_POSTGRES_PASSWORD") || "postgres",
  database: "traveler_test",
  hostname: System.get_env("DB_ENV_POSTGRES_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :traveler, TravelerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
