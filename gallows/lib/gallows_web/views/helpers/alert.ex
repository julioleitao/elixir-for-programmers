defmodule GallowsWeb.View.Alert do
  use GallowsWeb, :view

  def show(nil), do: ""

  def show({class, content}) do
    """
    <div class="alert alert-#{class}">
      #{content}
    </div>
    """
    |> raw()
  end
end
