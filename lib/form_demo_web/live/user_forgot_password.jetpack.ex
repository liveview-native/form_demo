defmodule FormDemoWeb.UserForgotPasswordLive.Jetpack do
  use FormDemoNative, [:render_component, format: :jetpack]

  def render(assigns, _) do
    ~LVN"""
    <Column>
    <.header>
      Forgot your password?
      <:subtitle>We'll send a password reset link to your inbox</:subtitle>
      <:actions>
        <Link navigate={~p"/users/register"}><Text>Register</Text></Link>
      </:actions>
    </.header>

    <.simple_form for={@form} id="reset_password_form" phx-submit="send_email">
      <.input field={@form[:email]} type="TextField" placeholder="Email" />
      <:actions>
        <.button type="submit">
          <Text>Send password reset instructions</Text>
        </.button>
      </:actions>
    </.simple_form>
    </Column>
    """
  end
end
