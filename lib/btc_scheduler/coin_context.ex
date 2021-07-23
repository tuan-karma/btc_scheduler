defmodule BtcScheduler.CoinContext do
  @moduledoc """
  The Coin context.
  """

  alias BtcScheduler.Repo
  alias BtcScheduler.Coin

  def list_coins do
    Repo.all(Coin)
  end

  @doc """
  Return {:ok, coin} it existed; {:error, :not_found} otherwise.
  """
  def get_coin(coin_id) do
    if coin = Repo.get_by(Coin, coin_id: coin_id) do
      {:ok, coin}
    else
      {:error, :not_found}
    end
  end

  def create_coin(attrs \\ %{}) do
    %Coin{}
    |> Coin.changeset(attrs)
    |> Repo.insert()
  end

  def update_coin(%Coin{} = coin, attrs) do
    coin
    |> Coin.changeset(attrs)
    |> Repo.update()
  end

  def delete_coin(%Coin{} = coin) do
    Repo.delete(coin)
  end

  def fetch_coincap(coin_id) do
    coin_id
    |> url()
    |> HTTPoison.get!()
    |> Map.get(:body)
    |> Jason.decode!()
    |> Map.get("data")
  end

  defp url(id) when is_binary(id) do
    "https://api.coincap.io/v2/assets/" <> id
  end
end
