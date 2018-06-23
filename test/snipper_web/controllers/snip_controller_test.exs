defmodule SnipperWeb.SnipControllerTest do
  use SnipperWeb.ConnCase

  alias Snipper.Core

  @create_attrs %{content: "some content", title: "some title"}
  @update_attrs %{content: "some updated content", title: "some updated title"}
  @invalid_attrs %{content: nil, title: nil}

  def fixture(:snip) do
    {:ok, snip} = Core.create_snip(@create_attrs)
    snip
  end

  describe "index" do
    test "lists all snips", %{conn: conn} do
      conn = get conn, snip_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Snips"
    end
  end

  describe "new snip" do
    test "renders form", %{conn: conn} do
      conn = get conn, snip_path(conn, :new)
      assert html_response(conn, 200) =~ "New Snip"
    end
  end

  describe "create snip" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, snip_path(conn, :create), snip: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == snip_path(conn, :show, id)

      conn = get conn, snip_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Snip"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, snip_path(conn, :create), snip: @invalid_attrs
      assert html_response(conn, 200) =~ "New Snip"
    end
  end

  describe "edit snip" do
    setup [:create_snip]

    test "renders form for editing chosen snip", %{conn: conn, snip: snip} do
      conn = get conn, snip_path(conn, :edit, snip)
      assert html_response(conn, 200) =~ "Edit Snip"
    end
  end

  describe "update snip" do
    setup [:create_snip]

    test "redirects when data is valid", %{conn: conn, snip: snip} do
      conn = put conn, snip_path(conn, :update, snip), snip: @update_attrs
      assert redirected_to(conn) == snip_path(conn, :show, snip)

      conn = get conn, snip_path(conn, :show, snip)
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, snip: snip} do
      conn = put conn, snip_path(conn, :update, snip), snip: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Snip"
    end
  end

  describe "delete snip" do
    setup [:create_snip]

    test "deletes chosen snip", %{conn: conn, snip: snip} do
      conn = delete conn, snip_path(conn, :delete, snip)
      assert redirected_to(conn) == snip_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, snip_path(conn, :show, snip)
      end
    end
  end

  defp create_snip(_) do
    snip = fixture(:snip)
    {:ok, snip: snip}
  end
end
