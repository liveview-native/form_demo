# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :form_demo,
  ecto_repos: [FormDemo.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :form_demo, FormDemoWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: FormDemoWeb.ErrorHTML, json: FormDemoWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: FormDemo.PubSub,
  live_view: [signing_salt: "ru4WiCkP"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :form_demo, FormDemo.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  form_demo: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.0",
  form_demo: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :live_view_native, plugins: [
  LiveViewNative.SwiftUI,
]

config :mime, :types, %{
  "text/swiftui" => ["swiftui"],
  "text/styles" => ["styles"]
}

# LVN - Required, you must configure LiveView Native Stylesheets
# on where class names shoudl be extracted from
config :live_view_native_stylesheet,
  content: [
    swiftui: [
      "lib/**/*swiftui*"
    ],
  ],
  output: "priv/static/assets"

# LVN - Required, you must configure Phoenix to know how
# to encode for the swiftui format
config :phoenix_template, :format_encoders, [
  swiftui: Phoenix.HTML.Engine,
]

# LVN - Required, you must configure Phoenix so it knows
# how to compile LVN's neex templates
config :phoenix, :template_engines, neex: LiveViewNative.Engine

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
