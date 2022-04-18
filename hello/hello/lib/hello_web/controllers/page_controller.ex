defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  def index(conn, _params) do
    page = %{title: "Te quiero Tania "}
    render(conn, "index.html", page: page)
  end
end
