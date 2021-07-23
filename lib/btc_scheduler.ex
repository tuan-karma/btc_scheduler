defmodule BtcScheduler do
  @moduledoc """
  This module provide public APIs for the app.
  """

  alias BtcScheduler.CoinContext
  alias BtcScheduler.CoinWorkerSupervisor

  @doc """
  Add a coin to DB and Supervision tree and start to monitoring it at certain interval.

  ## Examples

    iex> add_coin("bitcoin", 5000)
    {:ok, _pid}

  """
  def add_coin(coin_id, interval \\ 5000) when is_binary(coin_id) and is_integer(interval) do
    params = %{coin_id: coin_id, checking_interval: interval}

    with {:ok, coin} <- CoinContext.create_coin(params),
         {:ok, _pid} <-
           CoinWorkerSupervisor.start_coin_worker(%{
             coin_id: coin.coin_id,
             interval: coin.checking_interval
           }) do
      IO.puts("#{coin_id} is stored in DB.")
    end
  end

  @doc """
  Remove a coin from DB and Supervision tree and stop the monitoring.

  """
  def remove_coin(coin_id) when is_binary(coin_id) do
    with {1, nil} <- CoinContext.delete_coin_by_name(coin_id),
         :ok <- CoinWorkerSupervisor.stop_coin_worker(coin_id) do
      IO.inspect("#{coin_id} has been removed from DB and the Supervision tree.",
        label: "INFO"
      )
    else
      {:error, :nil_pid} ->
        IO.inspect("The #{coin_id} has been removed from DB.", label: "INFO")

      {0, _} ->
        IO.inspect("Non existing coin_id to remove from DB!", label: "INFO")

      other ->
        IO.inspect(other, label: "remove_coin OTHER")
    end
  end
end
