defmodule Test.Router do
  use Test.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Test do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
    resources "/users", UserController
    resources "/admins", AdminController, except: [:new, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Test do
  #   pipe_through :api
  # end
end
