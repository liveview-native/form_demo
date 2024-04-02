defmodule FormDemoWeb.UserRegistrationLive.Jetpack do
  use FormDemoNative, [:render_component, format: :jetpack]

  def render(assigns, _) do
    ~LVN"""
    <Text>Jetpack!</Text>
    """
  end
end
