alias KanbanApi.Repo
alias KanbanApi.Kanban.Task

# Limpa o banco antes de popular (opcional, mas ajuda a não duplicar)
# Repo.delete_all(Task)

Repo.insert!(%Task{
  title: "Finalizar Estrutura Elixir",
  description: "Configurar Phoenix, Absinthe e CORS para o front-end",
  priority: "critical",
  status: "doing",
  location: "Escritório Home Office",
  due_date: ~D[2026-02-20],
  attachments: ["https://elixir-lang.org/logo.png"]
})

Repo.insert!(%Task{
  title: "Estudar Recursão",
  description: "Praticar as 3 portas da recursão com exemplos práticos",
  priority: "high",
  status: "todo",
  location: "Biblioteca Central",
  due_date: ~D[2026-02-25],
  attachments: ["https://link-estudo.com/recursao.pdf"]
})

Repo.insert!(%Task{
  title: "Reunião de Alinhamento KanbanPro",
  description: "Apresentar a integração da API Elixir com o front-end dinâmico",
  priority: "high",
  status: "todo",
  location: "Sala de Reuniões Virtual",
  due_date: ~D[2026-02-16],
  attachments: []
})

Repo.insert!(%Task{
  title: "Beber Água",
  description: "Manter a hidratação constante durante o desenvolvimento",
  priority: "low",
  status: "done",
  location: "Cozinha",
  due_date: ~D[2026-02-14],
  attachments: []
})

IO.puts "Banco populado com sucesso com dados Premium! 🌱"