defmodule GallowsWeb.Router do
  use GallowsWeb, :router

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

  scope "/", GallowsWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/hangman", GallowsWeb do
    pipe_through :browser

    get "/", HangmanController, :index

    post "/", HangmanController, :create

    put "/", HangmanController, :put
  end

  # Other scopes may use custom stacks.
  # scope "/api", GallowsWeb do
  #   pipe_through :api
  # end
end
