defmodule BtcScheduler.StarterDbCoinWorkers do
  @moduledoc """
  Initialize/Start all coin workers which stored in DB.
  """
  use GenServer
  alias BtcScheduler.CoinContext
  alias BtcScheduler.CoinWorkerSupervisor

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(state) do
    start_db_coin_workers()
    {:ok, state}
  end

  defp start_db_coin_workers() do
    CoinContext.list_coins()
    |> Enum.map(fn coin ->
      params = %{coin_id: coin.coin_id, interval: coin.checking_interval}
      CoinWorkerSupervisor.start_coin_worker(params)
    end)
  end
end
