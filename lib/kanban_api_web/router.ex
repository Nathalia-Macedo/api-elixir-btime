defmodule KanbanApiWeb.Router do
  use KanbanApiWeb, :router
  import Phoenix.LiveDashboard.Router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  # Rotas de Desenvolvimento (Dashboard)
  # Nota: No Render (produção), o Mix.env() será :prod, então esta rota sumirá.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :api
      live_dashboard "/dashboard", metrics: KanbanApiWeb.Telemetry
    end
  end

  # Rotas da API e Documentação
  scope "/" do
    pipe_through :api

    # 1. ESPECÍFICA: Endpoint para o Frontend (React/Vercel)
    # Deve vir ANTES da rota raiz para não ser capturada pelo GraphiQL.
    forward "/api", Absinthe.Plug,
      schema: KanbanApiWeb.Schema

    # 2. GENÉRICA: Documentação Interativa (Playground)
    # Fica por último para servir como "página inicial" da sua API.
    forward "/", Absinthe.Plug.GraphiQL,
      schema: KanbanApiWeb.Schema,
      interface: :playground
  end
end