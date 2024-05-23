defmodule FormDemoWeb.UserRegistrationLive.Jetpack do
  use FormDemoNative, [:render_component, format: :jetpack]

  def render(assigns, _) do
    ~LVN"""
    <Column verticalArrangement="Center" class="box-style" size="fill">
      <AnimatedVisibility visible={"#{@isVisible}"} enter="[{'expandHorizontally': {}}]">
        <AsyncImage
          url="/images/logo.svg"
          contentScale="fillWidth">
          <Text template="error">Error loading image</Text>
          <CircularProgressIndicator template="loading"/>
        </AsyncImage>
      </AnimatedVisibility>
      <Button phx-click="toggleVisibility" phx-value={"#{if @isVisible == "true" do "false" else "true" end}"}><Text>Toggle Visibility</Text></Button>
      <Text class="box-style2" color="primary">Jetpack Compose!!!</Text>
      <Box class="box-size">
        <%= if @isExpanded == "true" do %>
        <Box size="100" background="system-red" />
        <% end %>
      </Box>
      <Button phx-click="buttonSize"><Text>Box Size</Text></Button>
      <Button phx-click="navigateToLogin"><Text>Login</Text></Button>
    </Column>
    """
  end
end
