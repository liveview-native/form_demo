defmodule FormDemoWeb.UserRegistrationLive.SwiftUI do
  use FormDemoNative, [:render_component, format: :swiftui]

  import FormDemoWeb.CoreComponents.SwiftUI

  def render(assigns, _) do
    ~LVN"""
    <.header class="multiline-text-alignment-center">
      Register
      <:actions>
        <.link navigate={~p"/users/log_in"} class="font-weight-semibold fg-tint">
          Sign in
        </.link>
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

      <.input field={@form[:email]} type="TextField" label="Email" required class="keyboard-type-emailAddress text-input-autocapitalization-never autocorrection-disabled" />
      <.input field={@form[:password]} type="SecureField" label="Password" required />

      <:actions>
        <.button type="submit">Create an account</.button>
      </:actions>
    </.simple_form>
    """
  end
end
