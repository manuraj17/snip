defmodule SnipperWeb.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  require Logger
  require IEx 
  use SnipperWeb, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{ email: auth.info.email, name: auth.info.name, 
      nickname: auth.info.nickname, token: "token" }
    changeset = Snipper.Core.User.changeset(%Snipper.Core.User{}, user_params)
    case create_or_update_user(changeset) do
      {:ok, user} ->
        conn 
        |> put_flash(:info, "Successfully authenticated.")
        |> redirect(to: "/")
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Sign in failed")
        |> redirect(to: "/")
    end
  end

  # Create user if does not exist
  def create_or_update_user(changeset) do
    IEx.pry
    case Snipper.Repo.get_by(Snipper.Core.User, email: changeset.changes.email) do
      nil -> Snipper.Repo.insert(changeset)
      user -> {:ok, user}
    end

  end
end
