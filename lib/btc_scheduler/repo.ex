defmodule BtcScheduler.Repo do
  use Ecto.Repo,
    otp_app: :btc_scheduler,
    adapter: Ecto.Adapters.Postgres
end
