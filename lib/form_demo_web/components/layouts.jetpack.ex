defmodule FormDemoWeb.Layouts.Jetpack do
  use FormDemoNative, [:layout, format: :jetpack]

  embed_templates "layouts_jetpack/*"
end
