import Foundation
import SwiftUI

struct AppMenu: View {
  @Environment(\.openURL) var openURL

  @Binding var posts: [StoryFetchResponse]
  @Binding var isFetching: Bool

  var onReloadTapped: () -> Void

  var body: some View {
    VStack(alignment: .leading) {
      if isFetching {
        Text("Loading feed…")
      } else {
        PostsListing(posts: posts)
      }
    }
  }
}
