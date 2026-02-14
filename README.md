# 🚀 Kanban API - Elixir & GraphQL

API Premium para gerenciamento de quadros Kanban, desenvolvida com Phoenix, Absinthe (GraphQL) e PostgreSQL.

## 🛠️ Tecnologias
- **Elixir** & **Phoenix Framework**
- **Absinthe** (GraphQL Implementation)
- **Ecto** (Banco de Dados)
- **PostgreSQL**

## 🚀 Como Rodar
1. Instale as dependências: `mix deps.get`
2. Crie e migre o banco: `mix ecto.setup`
3. (Opcional) Popule o banco: `mix run priv/repo/seeds.exs`
4. Inicie o servidor: `mix phx.server`

Acesse o Playground em: `http://localhost:4000/graphiql`

## 📊 Funcionalidades
- [x] CRUD completo de tarefas.
- [x] Filtro por prioridade e busca textual.
- [x] Paginação escalável (`page` e `page_size`).
- [x] Validação de data (não permite datas no passado).