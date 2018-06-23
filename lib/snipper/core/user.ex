defmodule Snipper.Core.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "user" do
    field :email, :string
    field :name, :string
    field :nickname, :string
    field :token, :string

    has_many :snips, Snipper.Core.Snip
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :token, :nickname])
    |> validate_required([:name, :email, :token, :nickname])
  end
end
