defmodule Wiki.Comment do
  use Wiki.Web, :model

  schema "comments" do
    field :body, :string
    belongs_to :page, Wiki.Page

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body])
    |> validate_required([:body])
  end
end
