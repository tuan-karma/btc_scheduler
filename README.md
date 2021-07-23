# BtcScheduler

  - Recurring work with GenServer
  - GenServer process that fetches the current price of Bitcoin at a regular interval
  - ref: https://elixircasts.io/recurring-work-with-genserver

# Improvement Plan

  - [x] Use Dynamic Supervisor to add more coin to track price from CLI
  - [x] Test: `iex -S mix` --> BtcScheduler.add_coin(:ethereum) ... --> :observer.start --> kill process --> STILL MONITORING (restart OK)
  - [ ] Add function to update Scheduler in run-time (update DB and update/recreate task)
