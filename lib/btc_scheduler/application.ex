defmodule BtcScheduler.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BtcScheduler.Repo,
      BtcScheduler.CoinWorkerSupervisor,
      BtcScheduler.StarterDbCoinWorkers
    ]

    opts = [strategy: :one_for_one, name: BtcScheduler.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
