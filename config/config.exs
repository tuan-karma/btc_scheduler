import Config

config :btc_scheduler, BtcScheduler.Repo,
  database: "btc_scheduler_repo",
  username: "postgres",
  password: "",
  hostname: "localhost"

config :btc_scheduler, ecto_repos: [BtcScheduler.Repo]
