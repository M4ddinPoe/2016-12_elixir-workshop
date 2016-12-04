defmodule Wiki.PageChannel do
  use Wiki.Web, :channel

  # def join("page:lobby", payload, socket) do
  #   if authorized?(payload) do
  #     {:ok, socket}
  #   else
  #     {:error, %{reason: "unauthorized"}}
  #   end
  # end
  
  def join("page:" <> page_id, payload, socket) do
    socket_with_page_id = assign(socket, :page_id, page_id)
    {:ok, socket_with_page_id}    
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (page:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end



  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
