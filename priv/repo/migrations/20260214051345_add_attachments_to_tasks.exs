defmodule KanbanApi.Repo.Migrations.AddAttachmentsToTasks do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      # Adiciona o campo de anexos como uma lista de strings (URLs)
      add :attachments, {:array, :string}, default: []
    end
  end
end