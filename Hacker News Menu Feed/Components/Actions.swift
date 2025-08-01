import Foundation
import SwiftUI

struct Actions: View {
  var onReload: () -> Void
  var onQuit: () -> Void

  @Binding var showHeadline: Bool

  var body: some View {
      HStack(alignment: .top) {
      Button(
        action: onReload,
        label: {
          Image(systemName: "arrow.clockwise")
        })

      Spacer()

      Toggle("Headline", isOn: $showHeadline)
        .toggleStyle(.button)

      Spacer()

      Button(
        action: onQuit,
        label: {
          Image(systemName: "power")
        })
    }
  }
}
