defmodule KanbanApi.Repo do
  use Ecto.Repo,
    otp_app: :kanban_api,
    adapter: Ecto.Adapters.Postgres
end
