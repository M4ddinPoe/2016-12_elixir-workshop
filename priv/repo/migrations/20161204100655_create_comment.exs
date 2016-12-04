defmodule Wiki.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text
      add :page_id, references(:pages, on_delete: :nothing)

      timestamps()
    end
    create index(:comments, [:page_id])

  end
end
