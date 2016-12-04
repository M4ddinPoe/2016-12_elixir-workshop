defmodule Wiki.Page do
  use Wiki.Web, :model

  @derive {Phoenix.Param, key: :title}
  schema "pages" do
    field :title, :string
    field :body, :string
    has_many :comments, Wiki.Comment, on_delete: :delete_all

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :body])
    |> validate_required([:title, :body])
    |> unique_constraint(:title)
  end
end
