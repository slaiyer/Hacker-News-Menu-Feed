import Foundation
import SwiftUI
import AppKit

struct PostsListing: View {
  var posts: [StoryFetchResponse]

  var body: some View {
    ForEach(
      Array(posts.enumerated()),
      id: \.element.id
    ) { _, post in
      HStack(alignment: .center) {
        Button {
          if let raw = post.url, let extURL = URL(string: raw) {
            NSWorkspace.shared.open(extURL)
          }
          let hnURL = URL(string: "https://news.ycombinator.com/item?id=\(post.id)")!
          NSWorkspace.shared.open(hnURL)
        } label: {
          Text("􀉣")
            .font(.system(size: 10))
            .foregroundColor(.secondary)
            .frame(maxHeight: .infinity)
        }
        .buttonStyle(.link)
        .contentShape(.rect)
        .onHover { hovering in
          if hovering {
            NSCursor.pointingHand.push()
          } else {
            NSCursor.pop()
          }
        }

        VStack(alignment: .leading) {
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
            HStack {
              Text("􀆇 \(post.score)")
                .frame(minWidth: 50, alignment: .leading)
              Text("􀌲 \(post.comments ?? 0)")
                .frame(minWidth: 50, alignment: .leading)
            }
            .font(.system(size: 10))
            .foregroundColor(.secondary)
          }
          .onHover { hovering in
            if hovering {
              NSCursor.pointingHand.push()
            } else {
              NSCursor.pop()
            }
          }
        }
      }
    }
  }
}
