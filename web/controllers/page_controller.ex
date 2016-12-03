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

    render conn, "edit.html", page: page
  end
end
