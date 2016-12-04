defmodule Wiki.CommentController do
  use Wiki.Web, :controller

  alias Wiki.Comment

  def index(conn, _params) do
    comments = Repo.all(Comment)
    render(conn, "index.html", comments: comments)
  end

  def new(conn, _params) do
    changeset = Comment.changeset(%Comment{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"comment" => comment_params}) do
    changeset = Comment.changeset(%Comment{}, comment_params)

    case Repo.insert(changeset) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: comment_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Repo.get!(Comment, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(comment)

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: comment_path(conn, :index))
  end
end
