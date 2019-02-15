defmodule Hangman.GameTest do
  use ExUnit.Case
  alias Hangman.Game

  doctest Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
    assert Enum.join(game.letters) =~ ~r/[a-z]/
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert {^game, _} = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    {game, _} = Game.new_game() |> Game.make_move("x")

    assert game.game_state != :already_used
  end

  test "second occurence of letter is already used" do
    {game, _} = Game.new_game() |> Game.make_move("x")
    {game, _} = Game.make_move(game, "x")

    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    {game, _} = Game.make_move(game, "w")

    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won state" do
    word = "wibble"
    game = Game.new_game(word)

    game =
      Enum.reduce(String.codepoints("wible"), game, fn guess, acc ->
        {game, _} = Game.make_move(acc, guess)
        game
      end)

    assert game.turns_left == 7
    assert game.game_state == :won
  end

  test "lost game is recognized" do
    word = "dust"
    game = Game.new_game(word)

    game =
      Enum.reduce(String.codepoints("akzxcpl"), game, fn guess, acc ->
        {game, _} = Game.make_move(acc, guess)
        game
      end)

    assert game.turns_left == 1
    assert game.game_state == :lost
  end
end
