//
//  NewsReaderAppApp.swift
//  NewsReaderApp
//
//  Created by Jeetendra on 14/09/24.
//

import SwiftUI

@main
struct NewsReaderAppApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                NewsListView()
                    .tabItem {
                        Label("News", systemImage: "newspaper")
                    }
                
                BookmarksView(viewModel: NewsViewModel())
                    .tabItem {
                        Label("Bookmarks", systemImage: "bookmark")
                    }
            }
        }
    }
}
