defmodule Wiki.PageController do
  use Wiki.Web, :controller 
  
  def index(conn, _params) do

    pages = Repo.all(Wiki.Page)

    render conn, "index.html", pages: pages
  end

  def show(conn, %{"id" => id}) do

    page = Repo.get_by!(Wiki.Page, title: id)
    render conn, "show.html", page: page
  end

  def edit(conn, %{"id" => id}) do

    page = Repo.get_by!(Wiki.Page, title: id)

    changeset = Wiki.Page.changeset(page)

    render conn, "edit.html", page: page, changeset: changeset
  end

  def update(conn, %{"id" => id, "page" => page_params}) do
    page = Repo.get_by!(Wiki.Page, title: id)

    changeset = Wiki.Page.changeset(page, page_params)

    case Repo.update(changeset) do
      {:ok, updated_page} ->
        redirect conn, to: page_path(conn, :show, updated_page.title)
      {:error, changeset} ->
        render conn, "edit.html", page: page, changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    page = Repo.get_by!(Wiki.Page, title: id)
  
    Repo.delete!(page)
    redirect conn, to: page_path(conn, :index)
  end
end
