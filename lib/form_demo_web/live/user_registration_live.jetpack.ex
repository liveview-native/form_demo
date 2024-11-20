defmodule FormDemoWeb.UserRegistrationLive.Jetpack do
  use FormDemoNative, [:render_component, format: :jetpack]

  def render(assigns, params) do
    ~LVN"""
    <Column>
    <.header class="multiline-text-alignment-center">
      Register
      <:actions>
        <Link navigate={~p"/users/log_in"}>
          <Text class="bodyMedium">Sign in</Text>
        </Link>
      </:actions>
    </.header>

    <.simple_form
      for={@form}
      id="registration_form"
      phx-submit="save"
      phx-change="validate"
      phx-trigger-action={@trigger_submit}
      action={~p"/users/log_in?_action=registered"}
      method="post"
    >
      <.error :if={@check_errors}>
        Oops, something went wrong! Please check the errors below.
      </.error>

      <.input field={@form[:email]} type="TextField" label="Email" keyboardType="EmailAddress" autoCorrectEnabled="false" />
      <.input field={@form[:password]} type="SecureField" label="Password" />

      <:actions>
        <.button type="submit">
          <Row verticalAlignment="CenterVertically">
            <Text template="title">Create an account</Text>
            <.image url={~p"/images/logo.png"} template="icon" />
          </Row>
        </.button>
      </:actions>
    </.simple_form>
    </Column>
    """
  end
end
