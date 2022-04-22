defmodule HelloWeb.RoomChannel do
  use HelloWeb, :channel

  @impl true
  def join("ChatChannel:lobby", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end
  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).
  @impl true
  def handle_in("new_message", payload, socket) do
    spawn(fn -> save_message(payload) end)
    broadcast socket, "new_message", payload
    {:noreply, socket}
  end

  def run_async do

  end

  defp save_message(message) do
    Hello.Message.changeset(%Hello.Message{}, message)
      |> Hello.Repo.insert
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  def handle_info(:after_join, socket) do
    Hello.Message.recent_messages()
      |> Enum.each(fn msg -> push(socket, "new_message", format_msg(msg)) end)
    {:noreply, socket}
  end

  defp format_msg(msg) do
    %{
      name: msg.name,
      message: msg.message
    }
  end
end
