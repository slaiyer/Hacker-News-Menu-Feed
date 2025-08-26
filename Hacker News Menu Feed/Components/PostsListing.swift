import Foundation
import SwiftUI

struct PostsListing: View {
  var posts: [StoryFetchResponse]

  var body: some View {
    ForEach(
      Array(posts.enumerated()),
      id: \.element.id
    ) { _, post in
      VStack(alignment: .leading, spacing: 4) {
        if let url = post.url {
          CustomLink(title: post.title ?? "", link: url)
            .foregroundColor(.primary)
            .help("\(post.title ?? "")\n\n\(url)")
        } else {
          Text(post.title ?? "")
            .foregroundColor(.primary)
            .help(post.title ?? "")
        }

        Link(destination: URL(string: "https://news.ycombinator.com/item?id=\(post.id)")!) {
          HStack() {
            Text("􀆇 \(post.score)")
              .frame(minWidth: 50, alignment: .leading)

            Text("􀌲 \(post.comments ?? 0)")
              .frame(minWidth: 50, alignment: .leading)
          }
          .font(.system(size: 10))
          .foregroundColor(.secondary)
        }
        .onHover(perform: { hovering in
          if hovering {
            NSCursor.pointingHand.push()
          } else {
            NSCursor.pop()
          }
        })
      }
    }
  }
}
