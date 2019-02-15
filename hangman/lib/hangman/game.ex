defmodule Hangman.Game do
  alias Hangman.Game

  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: [],
    used: MapSet.new()
  )

  def new_game() do
    new_game(Dictionary.random_word())
  end

  def new_game(word) do
    %Game{
      letters: word |> String.codepoints()
    }
  end

  def make_move(game = %{game_state: state}, _) when state in [:won, :lost] do
    game
    |> return_with_tally
  end

  def make_move(game, guess) do
    accept_move(game, guess, MapSet.member?(game.used, guess))
    |> return_with_tally
  end

  defp return_with_tally(game), do: {game, tally(game)}

  def accept_move(game, _guess, _already_guessed = true) do
    Map.put(game, :game_state, :already_used)
  end

  def accept_move(game, guess, _already_guessed) do
    Map.put(game, :used, MapSet.put(game.used, guess))
    |> score_guess(Enum.member?(game.letters, guess))
  end

  def score_guess(game, _good_guess = true) do
    new_state =
      MapSet.new(game.letters)
      |> MapSet.subset?(game.used)
      |> maybe_won

    Map.put(game, :game_state, new_state)
  end

  def score_guess(game = %{turns_left: 1}, _) do
    Map.put(game, :game_state, :lost)
  end

  def score_guess(game, _not_good_guess) do
    %{game | game_state: :bad_guess, turns_left: game.turns_left - 1}
  end

  def maybe_won(true), do: :won
  def maybe_won(_), do: :good_guess

  def tally(game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters: game.letters |> reveal_guessed(game.used)
    }
  end

  def reveal_guessed(letters, used) do
    letters
    |> Enum.map(fn letter ->
      reveal_letter(letter, MapSet.member?(used, letter))
    end)
  end

  def reveal_letter(letter, _in_word = true), do: letter

  def reveal_letter(_, false), do: "_"
end
