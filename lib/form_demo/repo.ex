defmodule FormDemo.Repo do
  use Ecto.Repo,
    otp_app: :form_demo,
    adapter: Ecto.Adapters.Postgres
end
