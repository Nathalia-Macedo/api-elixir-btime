# 🚀 Kanban API - Backend

Esta é uma API robusta e escalável desenvolvida com **Elixir**, **Phoenix** e **Absinthe (GraphQL)** para o desafio técnico KanbanPro. O projeto foi construído focando em alta performance, concorrência nativa da BEAM e uma interface de dados moderna.

## 🛠️ Stack Tecnológica e Arquitetura

* **Linguagem:** Elixir 1.15+ (Erlang/OTP).
* **Framework:** Phoenix 1.7+ (Modo API).
* **Interface:** GraphQL com Absinthe (Schema-first).
* **Banco de Dados:** PostgreSQL com Ecto.
* **Servidor Web:** Bandit (Servidor HTTP focado em performance).
* **Arquitetura:** Baseada em **Contextos do Phoenix**, garantindo que a lógica de negócio (`Kanban`) seja independente da camada de transporte (GraphQL).



## 🧠 Decisões de Engenharia

1.  **GraphQL vs REST:** Optamos por GraphQL para evitar problemas de *overfetching* e *underfetching*, permitindo que o front-end (KanbanPro) consuma apenas os campos necessários, como `attachments` e `priority`.
2.  **Filtros Dinâmicos:** Implementação de busca avançada usando `ilike` e fragmentos de Query do Ecto para filtrar por Local, Data, Prioridade e Termos de busca simultaneamente.
3.  **Segurança de Dados:** * Validações customizadas no `Ecto.Changeset` para impedir tarefas com datas retroativas.
    * Uso de `Enums` para garantir a integridade dos campos `status` e `priority`.
4.  **Performance:** Paginação baseada em `offset` e `limit` configurável via argumentos da Query.

## 📖 Documentação das Rotas (GraphQL)

A API utiliza o **GraphQL Playground** como documentação interativa. Ao rodar o projeto, você pode acessar a interface visual para explorar o Schema e testar as rotas em tempo real.

* **Documentação Interativa:** `http://localhost:4000/`
* **Endpoint de Produção:** `http://localhost:4000/api`

### Exemplos de Requisição

#### 🔍 Listar Tarefas (Query)
```graphql
query {
  listTasks(
    search: "Desenvolvimento",
    priority: "high",
    page: 1,
    page_size: 10
  ) {
    id
    title
    status
    location
    dueDate
    attachments
  }
}


➕ Criar Nova Tarefa (Mutation)
GraphQL
mutation {
  createTask(
    title: "Deploy da API",
    priority: "critical",
    location: "Cloud",
    dueDate: "2026-02-20",
    attachments: ["[https://docs.link.com/setup.pdf](https://docs.link.com/setup.pdf)"]
  ) {
    id
    title
  }
}
🚀 Como Executar
Instale as dependências:

Bash
mix deps.get
Crie e migre o banco de dados:

Bash
mix ecto.setup
Inicie o servidor Phoenix:

Bash
mix phx.server
Desenvolvido por Nathalia Macedo como parte do processo seletivo para a KanbanPro.