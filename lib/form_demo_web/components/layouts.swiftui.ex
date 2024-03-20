defmodule FormDemoWeb.Layouts.SwiftUI do
  use FormDemoNative, [:layout, format: :swiftui]

  embed_templates "layouts_swiftui/*"
end
