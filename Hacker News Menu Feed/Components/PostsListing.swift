import Foundation
import SwiftUI

struct PostsListing: View {
    @Environment(\.dismiss) var dismiss
    
    var posts: [StoryFetchResponse]
    
    var body: some View {
        ForEach(
            Array(posts.enumerated()),
            id: \.element.id) { index, post in
                VStack(alignment: .leading) {
                    if post.url != nil {
                        CustomLink(title: post.title!, link: post.url!)
                    } else {
                        Text(post.title!)
                    }
                
                    CustomLink(
                        title: "􀌲 \(post.comments ?? 0)    􀾙 \(post.score)",
                        link: "https://news.ycombinator.com/item?id=\(post.id)"
                    )
                    .padding(.leading)
                    .font(.system(size: 10))
                }
            
                Divider()
            }
    }
}
