defmodule Wiki.Router do
  use Wiki.Web, :router

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

  scope "/", Wiki do
    pipe_through :browser # Use the default browser stack

    resources "/comments", CommentController, except: [:show, :edit, :update]
    resources "/", PageController
    #get "/", PageController, :index
    #get "/:id", PageController, :show
    #get "/:id/edit", PageController, :edit
    #put "/:id", PageController, :update
    #delete "/:id", PageController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", Wiki do
  #   pipe_through :api
  # end
end
