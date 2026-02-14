defmodule KanbanApi.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :text
      add :due_date, :date
      add :location, :string
      add :priority, :string # low, high, critical
      add :status, :string, default: "todo" # funcionalidade premium: status!
      add :user_id, :integer # por enquanto apenas um ID, depois ligamos a um User real

      timestamps() # Cria o inserted_at e updated_at automaticamente
    end
  end
end