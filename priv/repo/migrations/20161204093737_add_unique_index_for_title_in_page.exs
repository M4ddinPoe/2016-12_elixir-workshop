defmodule Wiki.Repo.Migrations.AddUniqueIndexForTitleInPage do
  use Ecto.Migration

  def change do
    create unique_index(:pages, :title)
  end
end
