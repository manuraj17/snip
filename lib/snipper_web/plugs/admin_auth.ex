defmodule SnipperWeb.Plugs.AdminAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias SnipperWeb.Router.Helpers

  require Logger
  def init(_options) do
  end

  def call(conn, _params) do
    conn
    |> redirect(to: Helpers.page_path(conn, :index))
    |> halt()
  end
end
