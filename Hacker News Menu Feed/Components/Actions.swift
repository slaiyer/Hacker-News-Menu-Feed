import Foundation
import SwiftUI

struct Actions: View {
    var onRefresh: () -> Void
    var onQuit: () -> Void
    
    @Binding var showHeadline: Bool
    
    var body: some View {
        HStack {
            Button(action: onRefresh, label: {
                Image(systemName: "arrow.clockwise")
            })
            
            Divider()
            
            Toggle("Headline", isOn: $showHeadline)
                .toggleStyle(.button)
            
            Divider()
            
            Button(action: onQuit, label: {
                Image(systemName: "power")
            })
        }
        .padding(.top)
    }
}
