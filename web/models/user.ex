defmodule Wiki.User do
  use Wiki.Web, :model

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
  end

  def modify_password_changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password])
    |> changeset()
    |> encrypt_password()
  end

  def valid_password?(%__MODULE__{encrypted_password: encrypted_password}, input_password) do
    encrypted_password == hashed_password(input_password)
  end

  defp encrypt_password(%Ecto.Changeset{} = changeset) do
    string = hashed_password(changeset.params["password"])
    put_change(changeset, :encrypted_password, string)
  end

  defp hashed_password(password) do
    :crypto.hash(:sha256, password) |> Base.encode16
  end
end
