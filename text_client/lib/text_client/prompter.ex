defmodule TextClient.Prompter do

  alias TextClient.State

  def accept_move(game = %State{}) do
    IO.gets("You guess: ")
    |> check_input(game)
  end

  def check_input({:error, reason}, _) do
    IO.puts("Game ended: #{reason}")
    exit(:normal)
  end

  def check_input(:eof, _) do
    IO.puts "Look like you game up..."
    exit(:normal)
  end

  def check_input(input, game) do
    input = String.trim(input)

    cond do
      input =~ ~r/\A[a-z]\z/ ->
        Map.put(game, :guess, input)
      true ->
        IO.puts("Please enter a single lowercase letter")
        accept_move(game)
    end
  end
end
