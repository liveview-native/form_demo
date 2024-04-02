defmodule FormDemoWeb.UserForgotPasswordLive.SwiftUI do
  use FormDemoNative, [:render_component, format: :swiftui]

  import FormDemoWeb.CoreComponents.SwiftUI

  def render(assigns, _) do
    ~LVN"""
    <.header>
      Forgot your password?
      <:subtitle>We'll send a password reset link to your inbox</:subtitle>
      <:actions>
        <.link navigate={~p"/users/register"}>Register</.link>
      </:actions>
    </.header>

    <.simple_form for={@form} id="reset_password_form" phx-submit="send_email">
      <.input field={@form[:email]} type="TextField" placeholder="Email" />
      <:actions>
        <.button type="submit">
          Send password reset instructions
        </.button>
      </:actions>
    </.simple_form>
    """
  end
end
