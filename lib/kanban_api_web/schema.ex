defmodule KanbanApiWeb.Schema do
  use Absinthe.Schema

  alias KanbanApiWeb.Resolvers
  import_types Absinthe.Type.Custom # Necessário para o tipo :date

  @desc "Entidade representativa de uma tarefa no sistema Kanban"
  object :task do
    field :id, :id, description: "Identificador único (UUID ou Inteiro)"
    field :title, :string, description: "Título da tarefa"
    field :description, :string, description: "Detalhamento das atividades"
    field :due_date, :date, description: "Data de vencimento (Formato: YYYY-MM-DD)"
    field :location, :string, description: "Local físico ou remoto de execução"
    field :priority, :string, description: "Nível de criticidade (Ex: low, high, critical)"
    field :status, :string, description: "Estado atual (Ex: todo, doing, done)"
    field :user_id, :integer, description: "ID do usuário responsável"
    field :attachments, list_of(:string), description: "Lista de URLs de arquivos anexados"
  end

  @desc "Dados necessários para criar ou atualizar uma tarefa"
  input_object :task_input do
    field :title, :string
    field :description, :string
    field :priority, :string
    field :status, :string
    field :due_date, :date
    field :location, :string
    field :attachments, list_of(:string)
  end

  query do
    @desc "Busca avançada de tarefas com suporte a filtros e paginação"
    field :list_tasks, list_of(:task) do
      arg :search, :string, description: "Busca por termo no título ou descrição"
      arg :priority, :string, description: "Filtrar por nível de prioridade"
      arg :location, :string, description: "Filtrar por local específico"
      arg :due_date, :date, description: "Filtrar tarefas com vencimento em uma data específica"
      arg :page, :integer, description: "Número da página (Início: 1)"
      arg :page_size, :integer, description: "Quantidade de itens por página"
      
      resolve &Resolvers.Kanban.list_tasks/3
    end

    @desc "Busca uma tarefa específica pelo seu ID"
    field :get_task, :task do
      arg :id, non_null(:id), description: "ID da tarefa desejada"
      resolve &Resolvers.Kanban.get_task/3
    end
  end

  mutation do
    @desc "Cria uma nova tarefa no quadro Kanban"
    field :create_task, :task do
      arg :title, non_null(:string), description: "Título obrigatório"
      arg :priority, non_null(:string), description: "Prioridade obrigatória"
      arg :description, :string
      arg :status, :string
      arg :due_date, :date
      arg :location, :string
      arg :attachments, list_of(:string)

      resolve &Resolvers.Kanban.create_task/3
    end

    @desc "Atualiza os campos de uma tarefa existente"
    field :update_task, :task do
      arg :id, non_null(:id), description: "ID da tarefa a ser modificada"
      arg :input, non_null(:task_input), description: "Campos para atualização"

      resolve &Resolvers.Kanban.update_task/3
    end

    @desc "Remove permanentemente uma tarefa do sistema"
    field :delete_task, :task do
      arg :id, non_null(:id), description: "ID da tarefa a ser excluída"
      resolve &Resolvers.Kanban.delete_task/3
    end
  end
end