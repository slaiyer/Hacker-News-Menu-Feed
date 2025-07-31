import Foundation
import SwiftUI

struct AppMenu: View {
    @Environment(\.openURL) var openURL
    @Environment(\.dismiss) var dismiss
    
    @Binding var posts: [StoryFetchResponse]
    @Binding var isFetching: Bool
    @Binding var showHeadline: Bool
    
    var onRefreshTapped: () -> Void
    
    func quitAction() {
        NSApplication.shared.terminate(nil)
    }

    var body: some View {
        VStack(alignment: .leading) {
            if isFetching {
                Text("Refreshing HN feed…")
            } else {
                PostsListing(posts: posts)
                Actions(
                    onRefresh: onRefreshTapped,
                    onQuit: quitAction,
                    showHeadline: $showHeadline
                )
            }
        }
        .padding()
    }
}
