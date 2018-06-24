defmodule SnipperWeb.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias SnipperWeb.Router.Helpers

  def init(_options) do
  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)
    if user_id do
      conn
    else
      conn
      |> put_flash(:error, "Please sign in to continue")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt()
    end
  end
end
