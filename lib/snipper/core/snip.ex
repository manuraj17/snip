defmodule Snipper.Core.Snip do
  use Ecto.Schema
  import Ecto.Changeset


  schema "snips" do
    field :content, :string
    field :title, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(snip, attrs) do
    snip
    |> cast(attrs, [:title, :content, :user_id])
    |> validate_required([:title, :content, :user_id])
  end
end
