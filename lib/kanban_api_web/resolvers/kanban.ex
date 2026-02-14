defmodule KanbanApiWeb.Resolvers.Kanban do
  alias KanbanApi.Kanban

  # Lista tarefas com filtros e paginação
  def list_tasks(_parent, args, _resolution) do
    {:ok, Kanban.list_tasks(args)}
  end

  # Busca uma tarefa específica
  def get_task(_parent, %{id: id}, _resolution) do
    case Kanban.get_task!(id) do
      nil -> {:error, "Tarefa não encontrada"}
      task -> {:ok, task}
    end
  rescue
    _ -> {:error, "ID inválido"}
  end

  # Criação de tarefa
  def create_task(_parent, args, _resolution) do
    Kanban.create_task(args)
  end

  # Atualização de tarefa
  def update_task(_parent, %{id: id, input: attrs}, _resolution) do
    task = Kanban.get_task!(id)
    Kanban.update_task(task, attrs)
  end

  # Deleção de tarefa (Faltava esta!)
  def delete_task(_parent, %{id: id}, _resolution) do
    case Kanban.delete_task(id) do
      {:ok, task} -> {:ok, task}
      {:error, reason} -> {:error, reason}
    end
  end
end