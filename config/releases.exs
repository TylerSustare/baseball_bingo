# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

database_url = "ecto://postgres:w2dP2Z6X6ugXxtW27EA9@db.scstfwhpgibbkhyevzie.supabase.co"

# System.get_env("DATABASE_URL") ||
#   raise """
#   environment variable DATABASE_URL is missing.
#   For example: ecto://USER:PASS@HOST/DATABASE
#   """

config :live_view_studio, LiveViewStudio.Repo,
  ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base = "s2r+3lWWZ2ATaTGhHJD5Adh43Ocf0I4kz1ET5ytnSi6uj70K1LkOonpTpIYyM7BU"
# System.get_env("SECRET_KEY_BASE") ||
#   raise """
#   environment variable SECRET_KEY_BASE is missing.
#   You can generate one by calling: mix phx.gen.secret
#   """

config :live_view_studio, LiveViewStudioWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "8080"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
config :live_view_studio, LiveViewStudioWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
