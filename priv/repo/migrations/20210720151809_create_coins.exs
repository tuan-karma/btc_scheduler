defmodule BtcScheduler.Repo.Migrations.CreateCoins do
  use Ecto.Migration

  def change do
    create table(:coins) do
      add :coin_id, :string
      add :checking_interval, :integer

      timestamps()
    end

    create unique_index(:coins, [:coin_id])
  end
end
