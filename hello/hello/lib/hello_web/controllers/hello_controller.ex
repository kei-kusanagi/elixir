defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  def index(conn, _params) do
    conn
    |> put_flash(:info, "Welcome back! 😁")
    ## Da mensaje de error
    # |> put_flash(:error, "Mejor no 😒")
    ## Pone todo en texto plano
    # |> put_resp_content_type("text/plain")
    |> assign(:var, "I am a string")
    |> render("index.html")
    # render conn, "index.html"
  end

  def show(conn, %{"messenger" => messenger}) do
    render conn, "show.html", messenger: messenger
  end
end
