defmodule FormDemoWeb.UserRegistrationLive.SwiftUI do
  use FormDemoNative, [:render_component, format: :swiftui]

  import FormDemoWeb.CoreComponents.SwiftUI

  def render(assigns, _) do
    ~LVN"""
    <.form for={@form} phx-change="validate" phx-submit="save">
      <.input type="TextField" />
      <.button type="submit" />
    </.form>
    """
  end
end
