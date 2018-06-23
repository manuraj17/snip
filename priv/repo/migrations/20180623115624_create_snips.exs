defmodule Snipper.Repo.Migrations.CreateSnips do
  use Ecto.Migration

  def change do
    create table(:snips) do
      add :title, :string
      add :content, :text
      add :user_id, references(:user, on_delete: :nothing)

      timestamps()
    end

    create index(:snips, [:user_id])
  end
end
