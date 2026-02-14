defmodule KanbanApi.Kanban do
  import Ecto.Query, warn: false
  alias KanbanApi.Repo
  alias KanbanApi.Kanban.Task

  @doc """
  Lista tarefas com suporte a todos os requisitos do projeto:
  - Paginação (page, page_size)
  - Busca textual (search)
  - Filtro por prioridade (priority)
  - Filtro por local (location)
  - Filtro por data (due_date)
  """
  def list_tasks(filters \\ %{}) do
    page = Map.get(filters, :page, 1)
    page_size = Map.get(filters, :page_size, 10)
    offset = (page - 1) * page_size

    Task
    |> filter_with(filters)
    |> limit(^page_size)
    |> offset(^offset)
    |> Repo.all()
  end

  # 1. Filtro de busca textual (Título ou Descrição)
  defp filter_with(query, %{search: search}) when is_binary(search) and search != "" do
    from t in query, 
      where: ilike(t.title, ^"%#{search}%") or ilike(t.description, ^"%#{search}%")
  end

  # 2. Filtro por Prioridade
  defp filter_with(query, %{priority: priority}) when is_binary(priority) and priority != "" do
    from t in query, where: t.priority == ^priority
  end

  # 3. Filtro por Local de Execução (Requisito do projeto)
  defp filter_with(query, %{location: location}) when is_binary(location) and location != "" do
    from t in query, where: ilike(t.location, ^"%#{location}%")
  end

  # 4. Filtro por Data de Execução (Requisito do projeto)
  defp filter_with(query, %{due_date: date}) when not is_nil(date) do
    from t in query, where: t.due_date == ^date
  end

  # Caso base: retorna a query sem filtros adicionais
  defp filter_with(query, _), do: query

  # --- Funções de CRUD ---

  def get_task!(id), do: Repo.get!(Task, id)

  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  def delete_task(id) do
    case Repo.get(Task, id) do
      nil -> {:error, "Tarefa não encontrada"}
      task -> Repo.delete(task)
    end
  end
end