defmodule SnipperWeb.Router do
  use SnipperWeb, :router

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

  pipeline :authenticated do
    plug SnipperWeb.Plugs.RequireAuth
  end

  pipeline :admin_authenticated do
    plug SnipperWeb.Plugs.AdminAuth
  end

  scope "/", SnipperWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/logout", AuthController, :delete
  end

  scope "/", SnipperWeb do
    pipe_through [:browser, :authenticated]

    # resources "/users", UserController
    resources "/snips", SnipController
  end

  scope "/", SnipperWeb do
    pipe_through [:browser, :admin_authenticated]

    resources "/users", UserController
  end

  scope "/auth", SnipperWeb do
    pipe_through :browser
  
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", SnipperWeb do
  #   pipe_through :api
  # end
end
