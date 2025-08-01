import Foundation
import SwiftUI

struct AppMenu: View {
  @Environment(\.openURL) var openURL

  @Binding var posts: [StoryFetchResponse]
  @Binding var isFetching: Bool
  @Binding var showHeadline: Bool

  var onReloadTapped: () -> Void

  func quitAction() {
    NSApplication.shared.terminate(nil)
  }

  var body: some View {
    VStack(alignment: .leading) {
      if isFetching {
        Text("Reloading HN feed…")
      } else {
        PostsListing(posts: posts)
        Actions(
          onReload: onReloadTapped,
          onQuit: quitAction,
          showHeadline: $showHeadline
        )
      }
    }
    .padding()
  }
}
