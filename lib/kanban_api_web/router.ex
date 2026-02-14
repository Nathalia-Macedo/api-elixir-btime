defmodule KanbanApiWeb.Router do
  use KanbanApiWeb, :router
  import Phoenix.LiveDashboard.Router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  # Rotas de Desenvolvimento (Dashboard)
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :api # Usando o pipeline de API para evitar o erro do flash
      live_dashboard "/dashboard", metrics: KanbanApiWeb.Telemetry
    end
  end

  # Rotas da API e Documentação
  scope "/" do
    pipe_through :api

    # A rota raiz vira sua documentação estilo "Swagger"
    forward "/", Absinthe.Plug.GraphiQL,
      schema: KanbanApiWeb.Schema,
      interface: :playground

    # O endpoint que o seu Frontend vai consumir
    forward "/api", Absinthe.Plug,
      schema: KanbanApiWeb.Schema
  end
end