defmodule FormDemoWeb.Styles.App.SwiftUI do
  use LiveViewNative.Stylesheet, :swiftui

  ~SHEET"""
  "list-row-insets-zero" do
    listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
  end
  """

  @modifier_names ["accessibilityAction","accessibilityActions","accessibilityChildren","accessibilityIgnoresInvertColors","accessibilityRepresentation","accessibilityShowsLargeContentViewer","alert","allowsHitTesting","allowsTightening","animation","aspectRatio","autocorrectionDisabled","background","backgroundStyle","badge","baselineOffset","blendMode","blur","bold","border","brightness","buttonBorderShape","buttonStyle","clipShape","clipped","colorInvert","colorMultiply","compositingGroup","confirmationDialog","containerRelativeFrame","containerShape","contentShape","contentTransition","contextMenu","contrast","controlGroupStyle","controlSize","coordinateSpace","datePickerStyle","defaultScrollAnchor","defaultWheelPickerItemHeight","defersSystemGestures","deleteDisabled","dialogSuppressionToggle","digitalCrownAccessory","disabled","drawingGroup","dynamicTypeSize","fileDialogCustomizationID","fileDialogImportsUnresolvedAliases","findDisabled","findNavigator","fixedSize","flipsForRightToLeftLayoutDirection","focusEffectDisabled","focusSection","focusable","font","fontDesign","fontWeight","fontWidth","foregroundStyle","formStyle","frame","fullScreenCover","gaugeStyle","geometryGroup","gesture","grayscale","gridCellAnchor","gridCellColumns","gridCellUnsizedAxes","gridColumnAlignment","groupBoxStyle","headerProminence","help","hidden","highPriorityGesture","horizontalRadioGroupLayout","hoverEffect","hoverEffectDisabled","hueRotation","ignoresSafeArea","imageScale","indexViewStyle","inspector","inspectorColumnWidth","interactionActivityTrackingTag","interactiveDismissDisabled","invalidatableContent","italic","kerning","keyboardShortcut","keyboardType","labelStyle","labeledContentStyle","labelsHidden","layoutPriority","lineLimit","lineSpacing","listItemTint","listRowBackground","listRowHoverEffect","listRowHoverEffectDisabled","listRowInsets","listRowSeparator","listRowSeparatorTint","listRowSpacing","listSectionSeparator","listSectionSeparatorTint","listSectionSpacing","listStyle","luminanceToAlpha","menuIndicator","menuOrder","menuStyle","minimumScaleFactor","monospaced","monospacedDigit","moveDisabled","multilineTextAlignment","navigationBarBackButtonHidden","navigationBarTitleDisplayMode","navigationDestination","navigationSplitViewColumnWidth","navigationSplitViewStyle","navigationSubtitle","navigationTitle","offset","onAppear","onDeleteCommand","onDisappear","onExitCommand","onHover","onLongPressGesture","onLongTouchGesture","onMoveCommand","onPlayPauseCommand","onTapGesture","opacity","overlay","padding","persistentSystemOverlays","pickerStyle","popover","position","preferredColorScheme","presentationBackground","presentationBackgroundInteraction","presentationCompactAdaptation","presentationContentInteraction","presentationCornerRadius","presentationDragIndicator","previewDisplayName","privacySensitive","progressViewStyle","projectionEffect","redacted","refreshable","renameAction","replaceDisabled","rotationEffect","safeAreaInset","saturation","scaleEffect","scaledToFill","scaledToFit","scenePadding","scrollBounceBehavior","scrollClipDisabled","scrollContentBackground","scrollDisabled","scrollDismissesKeyboard","scrollIndicators","scrollIndicatorsFlash","scrollPosition","scrollTargetBehavior","scrollTargetLayout","searchDictationBehavior","searchPresentationToolbarBehavior","searchSuggestions","searchable","selectionDisabled","shadow","sheet","simultaneousGesture","speechAdjustedPitch","speechAlwaysIncludesPunctuation","speechAnnouncementsQueued","speechSpellsOutCharacters","statusBarHidden","strikethrough","submitLabel","submitScope","swipeActions","symbolEffectsRemoved","symbolRenderingMode","symbolVariant","tabItem","tabViewStyle","tableStyle","textCase","textContentType","textEditorStyle","textFieldStyle","textInputAutocapitalization","textScale","textSelection","tint","toggleStyle","toolbar","toolbarBackground","toolbarColorScheme","toolbarRole","toolbarTitleDisplayMode","toolbarTitleMenu","touchBarCustomizationLabel","touchBarItemPrincipal","tracking","transformEffect","transition","truncationMode","underline","unredacted","zIndex"]
    ++ ["stroke", "mask", "onSubmit"]
  @aliases %{
    "px" => "padding-horizontal",
    "py" => "padding-vertical",
    "pt" => "padding-top",
    "pr" => "padding-trailing",
    "pb" => "padding-bottom",
    "pl" => "padding-leading",
    "p" => "padding",
    "w-" => "frame-width:",
    "h-" => "frame-height:",
    "min-w-" => "frame-minWidth:",
    "max-w-" => "frame-maxWidth:",
    "min-h-" => "frame-minHeight:",
    "max-h-" => "frame-maxHeight:",
    "fg" => "foreground-style",
    "bg" => "background",
    "overlay--" => "overlay-content::",
    "bg--" => "background-content::",
    "mask--" => "mask-mask::",
    "toolbar--" => "toolbar-content::",
    "safe-area-inset--" => "safe-area-inset-content::",
  }

  for {key, value} <- Enum.sort_by(@aliases, fn {k, _} -> String.length(k) end, :desc) do
    def class(unquote(key)) do
      class(unquote(value))
    end
    if String.ends_with?(key, "-") do
      def class(unquote(key) <> arguments) do
        class(unquote(value) <> arguments)
      end
    else
      def class(unquote(key) <> "-" <> arguments) do
        class(unquote(value) <> "-" <> arguments)
      end
    end
  end

  for modifier <- Enum.sort_by(@modifier_names, &String.length/1, :desc) do
    kebab_name = modifier |> Macro.underscore() |> String.replace("_", "-")
    def class(unquote(kebab_name) <> arguments) do
      name = unquote(modifier)
      arguments = arguments
        |> String.trim_leading("-") # remove dash separating first argument
        |> String.split(~r/(?<!-|:)-/) # arguments separated by a dash
        |> Enum.map(fn arg ->
          if String.contains?(arg, ":") and not String.starts_with?(arg, ":") do
            [name | value] = String.split(arg, ":")
            value = Enum.join(value, ":")
            "#{name}: #{encode_argument(value)}" # add space between label and value
          else
            "#{encode_argument(arg)}" # encode argument values
          end
        end)
        |> Enum.join(", ") # rejoin arguments with commas instead of dashes
        |> String.replace(":.", ": .")
      try do
        ~RULES"""
        <%= name %>(<%= arguments %>)
        """
      rescue
        _ ->
          {:unmatched, ""}
      end
    end
  end

  defp encode_argument(value) when value in ["true", "false", "nil"], do: value
  defp encode_argument(value) do
    case Regex.run(~r/^(\[)attr\(([^)]+)\)(\])$/, value) do # [attr(attribute)]
      [_, _, attr, _] ->
        "attr(\"#{attr}\")"
      _ ->
        case Regex.run(~r/^(\[)event\(([^)]+)\)(\])$/, value) do # [event(attribute)]
          [_, _, event, _] ->
            "__event__(\"#{event}\")"
          _ ->
            case Regex.run(~r/^\['([^']*)'\]$/, value) do # ['string_value']
              [_, string] ->
                "\"#{Regex.replace(~r/(?<!\\)_/, string, " ")}\"" # replace `_` with space unless escaped
              _ ->
              if Regex.match?(~r/^[A-z]([A-z]|\d|_)*$/, value) do
                ".#{value}" # plain text arguments are treated as `.` members
              else
                value
              end
            end
        end
    end
  end
end
