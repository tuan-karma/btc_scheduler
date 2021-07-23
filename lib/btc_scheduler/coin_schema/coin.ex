defmodule BtcScheduler.Coin do
  use Ecto.Schema
  import Ecto.Changeset

  schema "coins" do
    field(:coin_id, :string)
    field(:checking_interval, :integer)

    timestamps()
  end

  def changeset(coin, attrs) do
    coin
    |> cast(attrs, [:coin_id, :checking_interval])
    |> validate_required([:coin_id, :checking_interval])
    |> unique_constraint(:coin_id)
  end
end
