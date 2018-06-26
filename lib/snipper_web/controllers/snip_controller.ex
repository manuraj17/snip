defmodule SnipperWeb.SnipController do
  use SnipperWeb, :controller

  alias Snipper.Core
  alias Snipper.Core.Snip
  require IEx

  plug :set_snip when action in [:show, :edit, :update, :delete]
  plug :validate_user_snip when action in [:show, :edit, :update, :delete]

  def index(conn, _params) do
    snips = Core.list_user_snips(get_session(conn, :user_id))
    render(conn, "index.html", snips: snips)
  end

  def new(conn, _params) do
    changeset = Core.change_snip(%Snip{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"snip" => snip_params}) do
    case Core.create_snip(Map.put(snip_params, "user_id", get_session(conn, :user_id))) do
      {:ok, snip} ->
        conn
        |> put_flash(:info, "Snip created successfully.")
        |> redirect(to: snip_path(conn, :show, snip))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    snip = Core.get_snip!(id)
    render(conn, "show.html", snip: snip)
  end

  def edit(conn, %{"id" => id}) do
    snip = Core.get_snip!(id)
    changeset = Core.change_snip(snip)
    render(conn, "edit.html", snip: snip, changeset: changeset)
  end

  def update(conn, %{"id" => id, "snip" => snip_params}) do
    snip = Core.get_snip!(id)

    case Core.update_snip(snip, snip_params) do
      {:ok, snip} ->
        conn
        |> put_flash(:info, "Snip updated successfully.")
        |> redirect(to: snip_path(conn, :show, snip))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", snip: snip, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    snip = Core.get_snip!(id)
    {:ok, _snip} = Core.delete_snip(snip)

    conn
    |> put_flash(:info, "Snip deleted successfully.")
    |> redirect(to: snip_path(conn, :index))
  end

  def set_user(conn, _) do
    assign(conn, :user, Snipper.Repo.get(Snipper.Core.User, conn.params["user_id"]))
  end

  def set_snip(conn, _) do
    assign(conn, :snip, Snipper.Repo.get(Snipper.Core.Snip, conn.params["id"]))
  end

  def validate_user_snip(conn, _) do
    user_id = get_session(conn, :user_id)
    if conn.assigns.snip.user_id == user_id do
      conn
    else
      conn
      |> put_flash(:error, "Snip not found")
      |> redirect(to: snip_path(conn, :index))
      |> halt()
    end
  end
end
