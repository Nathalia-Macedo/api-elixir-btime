defmodule KanbanApiWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :kanban_api

  @session_options [
    store: :cookie,
    key: "_kanban_api_key",
    signing_salt: "3IhoeQCt",
    same_site: "Lax"
  ]

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: @session_options]],
    longpoll: [connect_info: [session: @session_options]]

  plug Plug.Static,
    at: "/",
    from: :kanban_api,
    gzip: not code_reloading?,
    only: KanbanApiWeb.static_paths(),
    raise_on_missing_only: code_reloading?

  if code_reloading? do
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :kanban_api
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options

  # --- CONFIGURAÇÃO DO CORS ---
  # Permite que o seu front-end acesse a API. 
  # O origin: "*" libera para qualquer origem (ideal para desenvolvimento).
  plug CORSPlug, origin: "*"

  plug KanbanApiWeb.Router
end