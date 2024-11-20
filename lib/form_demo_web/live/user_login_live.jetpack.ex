defmodule FormDemoWeb.UserLoginLive.Jetpack do
  use FormDemoNative, [:render_component, format: :jetpack]

  def render(assigns, _) do
    ~LVN"""
    <Column>
    <.header class="text-center">
      Sign in to account
      <:actions>
        <Link navigate={~p"/users/register"}>
          <Text textStyle="bodyMedium">Sign up</Text>
        </Link>
      </:actions>
    </.header>

    <.simple_form for={@form} id="login_form" action={~p"/users/log_in"} method="post" phx-update="ignore">
      <.input type="TextField" field={@form[:email]} label="Email" keyboardType="Email"/>
      <.input type="SecureField" field={@form[:password]} label="Password" />

      <Link navigate={~p"/users/reset_password"} >
        <Text textStyle="bodyMedium">Forgot your password?</Text>
      </Link>

      <.input field={@form[:remember_me]} type="Checkbox" label="Keep me logged in" />

      <:actions>
        <.button type="submit">
          <Row verticalAlignment="CenterVertically"><Text>Sign in</Text><.icon name="AutoMirrored.Filled:ArrowRight" /></Row>
        </.button>
      </:actions>
    </.simple_form>
    </Column>
    """
  end
end
