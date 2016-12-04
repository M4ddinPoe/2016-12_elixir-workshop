defmodule Wiki.AuthenticationPlug do
  alias Wiki.{Repo, User}
  use Phoenix.Controller
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)

    user =
      if user_id do
        get_user_from_database(user_id)
      else
        nil
      end

    assign(conn, :current_user, user)
  end

  defp get_user_from_database(user_id) do
    case Repo.get(User, user_id) do
      %User{} = user -> user
      _              -> nil
    end
  end
end