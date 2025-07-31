defmodule Playing.Repo do
  use Ecto.Repo,
    otp_app: :playing,
    adapter: Ecto.Adapters.Postgres
end
