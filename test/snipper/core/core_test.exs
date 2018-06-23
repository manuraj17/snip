defmodule Snipper.CoreTest do
  use Snipper.DataCase

  alias Snipper.Core

  describe "user" do
    alias Snipper.Core.User

    @valid_attrs %{email: "some email", name: "some name", nickname: "some nickname", token: "some token"}
    @update_attrs %{email: "some updated email", name: "some updated name", nickname: "some updated nickname", token: "some updated token"}
    @invalid_attrs %{email: nil, name: nil, nickname: nil, token: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Core.create_user()

      user
    end

    test "list_user/0 returns all user" do
      user = user_fixture()
      assert Core.list_user() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Core.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Core.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.nickname == "some nickname"
      assert user.token == "some token"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Core.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.nickname == "some updated nickname"
      assert user.token == "some updated token"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_user(user, @invalid_attrs)
      assert user == Core.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Core.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Core.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Core.change_user(user)
    end
  end

  describe "snips" do
    alias Snipper.Core.Snip

    @valid_attrs %{content: "some content", title: "some title"}
    @update_attrs %{content: "some updated content", title: "some updated title"}
    @invalid_attrs %{content: nil, title: nil}

    def snip_fixture(attrs \\ %{}) do
      {:ok, snip} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Core.create_snip()

      snip
    end

    test "list_snips/0 returns all snips" do
      snip = snip_fixture()
      assert Core.list_snips() == [snip]
    end

    test "get_snip!/1 returns the snip with given id" do
      snip = snip_fixture()
      assert Core.get_snip!(snip.id) == snip
    end

    test "create_snip/1 with valid data creates a snip" do
      assert {:ok, %Snip{} = snip} = Core.create_snip(@valid_attrs)
      assert snip.content == "some content"
      assert snip.title == "some title"
    end

    test "create_snip/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_snip(@invalid_attrs)
    end

    test "update_snip/2 with valid data updates the snip" do
      snip = snip_fixture()
      assert {:ok, snip} = Core.update_snip(snip, @update_attrs)
      assert %Snip{} = snip
      assert snip.content == "some updated content"
      assert snip.title == "some updated title"
    end

    test "update_snip/2 with invalid data returns error changeset" do
      snip = snip_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_snip(snip, @invalid_attrs)
      assert snip == Core.get_snip!(snip.id)
    end

    test "delete_snip/1 deletes the snip" do
      snip = snip_fixture()
      assert {:ok, %Snip{}} = Core.delete_snip(snip)
      assert_raise Ecto.NoResultsError, fn -> Core.get_snip!(snip.id) end
    end

    test "change_snip/1 returns a snip changeset" do
      snip = snip_fixture()
      assert %Ecto.Changeset{} = Core.change_snip(snip)
    end
  end
end
