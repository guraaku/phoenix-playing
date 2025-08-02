defmodule PlayingWeb.PageController do
  use PlayingWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def qwerty(conn, _params) do
    render(conn, :home, layout: false)
  end
end
