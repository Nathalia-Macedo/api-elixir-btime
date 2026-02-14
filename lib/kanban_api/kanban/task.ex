defmodule KanbanApi.Kanban.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :title, :string
    field :description, :string
    field :due_date, :date
    field :location, :string
    field :priority, :string
    field :status, :string, default: "todo"
    field :user_id, :integer
    # Requisito: Arquivos anexos (URLs ou identificadores)
    field :attachments, {:array, :string}, default: []

    timestamps()
  end

  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :due_date, :location, :priority, :status, :user_id, :attachments])
    |> validate_required([:title, :priority])
    # Garante os valores exatos pedidos no requisito
    |> validate_inclusion(:priority, ["low", "high", "critical"])
    |> validate_inclusion(:status, ["todo", "doing", "done"])
    |> validate_future_date(:due_date)
  end

  defp validate_future_date(changeset, field) do
    validate_change(changeset, field, fn _, value ->
      if value && Date.compare(value, Date.utc_today()) == :lt do
        [{field, "não pode ser no passado"}]
      else
        []
      end
    end)
  end
end