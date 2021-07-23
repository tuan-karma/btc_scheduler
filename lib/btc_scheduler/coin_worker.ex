defmodule BtcScheduler.CoinWorker do
  use GenServer, restart: :transient
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
    with {:ok, coin_data} <- fetch_coin_data(:fake) do
      new_state = update_state(coin_data, state)
      maybe_display_price(new_state, state)
      schedule_coin_fetch(new_state[:interval])
      {:noreply, new_state}
    else
      {:error, _reason} ->
        IO.inspect("Cannot fetch the coin data from coincap! Remove DB and Stop worker!",
          label: "WARN"
        )

        CoinContext.delete_coin_by_name(state[:coin_id])
        {:stop, :normal, state}
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

  defp fetch_coin_data(:fake) do
    with :ok <- CoinContext.do_some_work_in_milliseconds("faking job", 10_000) do
      {:ok, %{"name" => "fakecoin", "priceUsd" => "123456"}}
    end
  end

  defp fetch_coin_data(state) do
    with %{"name" => _, "priceUsd" => _} = coin_data <- CoinContext.fetch_coincap(state[:coin_id]) do
      {:ok, coin_data}
    else
      _nil ->
        {:error, nil}
    end
  end
end
