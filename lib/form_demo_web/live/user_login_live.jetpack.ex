defmodule FormDemoWeb.UserLoginLive.Jetpack do
  use FormDemoNative, [:render_component, format: :jetpack]

  def render(assigns, _) do
    ~LVN"""
    <Box size="fill" background="system-blue">
      <Text align="Center">Hello</Text>
    </Box>
    """
  end
end
