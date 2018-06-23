defmodule Snipper.Core do
  @moduledoc """
  The Core context.
  """

  import Ecto.Query, warn: false
  alias Snipper.Repo

  alias Snipper.Core.User

  @doc """
  Returns the list of user.

  ## Examples

      iex> list_user()
      [%User{}, ...]

  """
  def list_user do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias Snipper.Core.Snip

  @doc """
  Returns the list of snips.

  ## Examples

      iex> list_snips()
      [%Snip{}, ...]

  """
  def list_snips do
    Repo.all(Snip)
  end

  @doc """
  Gets a single snip.

  Raises `Ecto.NoResultsError` if the Snip does not exist.

  ## Examples

      iex> get_snip!(123)
      %Snip{}

      iex> get_snip!(456)
      ** (Ecto.NoResultsError)

  """
  def get_snip!(id), do: Repo.get!(Snip, id)

  @doc """
  Creates a snip.

  ## Examples

      iex> create_snip(%{field: value})
      {:ok, %Snip{}}

      iex> create_snip(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_snip(attrs \\ %{}) do
    %Snip{}
    |> Snip.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a snip.

  ## Examples

      iex> update_snip(snip, %{field: new_value})
      {:ok, %Snip{}}

      iex> update_snip(snip, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_snip(%Snip{} = snip, attrs) do
    snip
    |> Snip.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Snip.

  ## Examples

      iex> delete_snip(snip)
      {:ok, %Snip{}}

      iex> delete_snip(snip)
      {:error, %Ecto.Changeset{}}

  """
  def delete_snip(%Snip{} = snip) do
    Repo.delete(snip)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking snip changes.

  ## Examples

      iex> change_snip(snip)
      %Ecto.Changeset{source: %Snip{}}

  """
  def change_snip(%Snip{} = snip) do
    Snip.changeset(snip, %{})
  end
end
