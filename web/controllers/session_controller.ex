defmodule Wiki.SessionController do
  use Wiki.Web, :controller

  alias Wiki.User

  def new(conn, _params) do
    # you need to create a changeset here
    # render the new template and pass the changeset to it
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    user = Repo.get_by(User, email: user_params["email"])

    if user && User.valid_password?(user, user_params["password"]) do # call the User.valid_password? method here
      conn
      |> put_session(:user_id, user.id)
      |> redirect(to: page_path(conn, :index))
    else
      changeset =
        %User{email: user_params[:email]}
        |> User.changeset()
        |> Ecto.Changeset.add_error(:base, "email or password is invalid")

      new_changeset = %{changeset | action: :insert, errors: changeset.errors}
      render(conn, "new.html", changeset: new_changeset)
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:user_id)
    |> redirect(to: session_path(conn, :new))
  end
end