defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  alias GallowsWeb.View.Alert

  @responses %{
    :won => {:success, "You Won!"},
    :lost => {:danger, "You Lost!"},
    :good_guess => {:success, "Good guess!"},
    :bad_guess => {:warning, "Bad guess! Try again..."},
    :already_used => {:info, "You already guessed that before..."}
  }

  def game_state(state) do
    @responses[state]
    |> Alert.show
  end
end
