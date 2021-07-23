defmodule BtcScheduler.CoinWorker do
  use GenServer
  alias BtcScheduler.CoinContext

  def start_link(args) do
    coin_id = Map.get(args, :coin_id)
    GenServer.start_link(__MODULE__, args, name: String.to_atom(coin_id))
  end

  @impl true
  def init(state) do
    schedule_coin_fetch(state[:interval])
    {:ok, state}
  end

  @impl true
  def handle_info(:coin_fetch, state) do
    with %{"name" => _, "priceUsd" => _} = coin_data <- CoinContext.fetch_coincap(state[:coin_id]) do
      new_state = update_state(coin_data, state)
      maybe_display_price(new_state, state)
      schedule_coin_fetch(new_state[:interval])
      {:noreply, new_state}
    else
      _nil ->
        IO.inspect("Cannot fetch the coin data from coincap! --> Delete and Shutdown!",
          label: "WARN"
        )

        BtcScheduler.remove_coin(state[:coin_id])
        {:noreply, state}
    end
  end

  defp maybe_display_price(new_state, state) do
    if new_state[:price] != state[:price] do
      IO.inspect(
        "Current #{new_state[:name]} price is $#{new_state[:price]}. Interval: #{new_state[:interval]}"
      )
    end
  end

  defp update_state(%{"name" => name, "priceUsd" => price}, state) do
    state
    |> Map.put(:name, name)
    |> Map.put(:price, price)
  end

  defp schedule_coin_fetch(interval) do
    Process.send_after(self(), :coin_fetch, interval)
  end
end
