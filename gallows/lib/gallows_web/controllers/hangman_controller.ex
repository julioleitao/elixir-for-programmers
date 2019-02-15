defmodule GallowsWeb.HangmanController do
  use GallowsWeb, :controller

  def index(conn, _params) do
    render(conn, "new_hangman.html")
  end

  def create(conn, _params) do
    game = Hangman.new_game()
    tally = Hangman.tally(game)

    conn
    |> put_session(:game, game)
    |> render("game_field.html", tally: tally)
  end

  def put(conn, params) do
    tally =
      conn
      |> get_session(:game)
      |> Hangman.make_move(params["put"]["guess"])

    put_in(conn.params["put"]["guess"], "")
    |> render("game_field.html", tally: tally)
  end
end
