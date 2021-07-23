defmodule BtcScheduler.CoinWorkerSupervisor do
  use DynamicSupervisor

  alias BtcScheduler.CoinWorker

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_coin_worker(%{coin_id: coin_id, interval: _interval} = args) do
    IO.puts("A worker is started to monitor #{coin_id} price.")
    DynamicSupervisor.start_child(__MODULE__, {CoinWorker, args})
  end

  def stop_coin_worker(coin_id) when is_binary(coin_id) do
    with worker_pid <- Process.whereis(String.to_atom(coin_id)),
         true <- is_pid(worker_pid) do
      DynamicSupervisor.terminate_child(__MODULE__, worker_pid)
    else
      false -> {:error, :nil_pid}
    end
  end
end
