defmodule Test.HelloController do
  use Test.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
