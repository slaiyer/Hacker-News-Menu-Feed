import Foundation
import SwiftUI

struct PostsListing: View {
  var posts: [StoryFetchResponse]

  var body: some View {
    ForEach(
      Array(posts.enumerated()),
      id: \.element.id
    ) { _, post in
      VStack(alignment: .leading) {
        if post.url != nil {
          CustomLink(title: post.title!, link: post.url!)
            .foregroundColor(.primary)
        } else {
          Text(post.title!)
            .foregroundColor(.primary)
        }

        CustomLink(
          title: "􀌲 \(post.comments ?? 0)",
          link: "https://news.ycombinator.com/item?id=\(post.id)"
        )
        .padding(.leading)
        .font(.system(size: 10))
        .foregroundColor(.secondary)
      }
    }
  }
}
