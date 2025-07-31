import SwiftUI

@main
struct ContentView: App {
    private static let NUMBER_OF_POSTS = 10
    
    @State private var isFetching = false
    @State private var showHeadline = LocalDataSource.getShowHeadline()
    @State private var truncatedTitle: String = "Loading HN…"
    @State private var posts: [StoryFetchResponse] = []
    @State private var reloadRate = 600.0
    
    var timer = Timer()
    
    var body: some Scene {
        MenuBarExtra {
            AppMenu(
                posts: $posts,
                isFetching: $isFetching,
                showHeadline: $showHeadline,
                onReloadTapped: reloadData
            )
            .frame(width: 500.0)
        } label: {
            if showHeadline {
                Text(truncatedTitle)
                    .onAppear() {
                        startApp()
                    }
            } else {
                Image(.icon).frame(width: 5, height: 5)
                    .onAppear() {
                        startApp()
                    }
            }
        }
        .menuBarExtraStyle(.window)
        .onChange(of: isFetching, perform: { _ in
            if !isFetching && posts.count > 0 {
                truncatedTitle = posts[0].title!
            }
            
            adjustTitleForMenuBar()
        })
        .onChange(of: showHeadline, perform: { _ in
            LocalDataSource.saveShowHeadline(value: showHeadline)
        })
    }
    
    func startApp() {
        if posts.count == 0 {
            reloadData()
            Timer
                .scheduledTimer(withTimeInterval: reloadRate, repeats: true, block: { _ in
                    reloadData()
                })
        }
    }
    
    func adjustTitleForMenuBar() {
        let maxMenuBarWidth: CGFloat = 250
        truncatedTitle = truncateStringToFit(
            truncatedTitle,
            maxWidth: maxMenuBarWidth
        )
    }
    
    func truncateStringToFit(_ string: String, maxWidth: CGFloat) -> String {
        // Create a temporary label to measure the string width
        let label = NSTextField(labelWithString: string)
        label.sizeToFit()
            
        if label.frame.width <= maxWidth {
            return string
        }

        var truncatedString = string
        while label.frame.width > maxWidth && truncatedString.count > 0 {
            truncatedString.removeLast()
            label.stringValue = truncatedString + "…"
            label.sizeToFit()
        }
            
        return truncatedString + "…"
    }
    
    func reloadData() {
        isFetching = true
        
        Task {
            do {
                try await fetchFeed()
            } catch {
                print("Error: \(error)")
            }
            
            isFetching = false
        }
    }
    
    func fetchFeed() async throws {
        let postsIds = try await fetchTopPostsIDs()
        var newPosts: [StoryFetchResponse] = []
        
        for postId in postsIds {
            let post = try await fetchPostById(postId: postId)
            newPosts.append(post)
        }
        
        posts = newPosts
    }
    
    func fetchTopPostsIDs() async throws -> [Int] {
        let url = URL(
            string: "https://hacker-news.firebaseio.com/v0/topstories.json"
        )!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode([Int].self, from: data)
        
        return Array(response.prefix(ContentView.NUMBER_OF_POSTS))
    }
    
    func fetchPostById(postId: Int) async throws -> StoryFetchResponse {
        let url = URL(
            string: "https://hacker-news.firebaseio.com/v0/item/\(postId).json"
        )!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode(StoryFetchResponse.self, from: data)
    }
}

