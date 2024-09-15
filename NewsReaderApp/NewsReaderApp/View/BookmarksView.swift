//
//  BookmarksView.swift
//  NewsReaderApp
//
//  Created by Jeetendra on 14/09/24.
//

import SwiftUI

struct BookmarksView: View {
    @ObservedObject var viewModel: NewsViewModel
    @State private var isEditing: EditMode = .inactive
    var body: some View {
        NavigationView {
            List{
                ForEach(viewModel.bookmarkedArticles, id: \.self) { article in
                    NavigationLink(destination: ArticleDetailView(article: NewsArticle(id: article.id ?? UUID(), title: article.title ?? "", description: article.summary, url: article.url ?? "", urlToImage: article.urlToImage), viewModel: viewModel)) {
                        VStack(alignment: .leading) {
                            Text(article.title ?? "")
                                .font(.headline)
                            Text(article.summary ?? "No description available")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteArticle)
                .disabled(viewModel.bookmarkedArticles.isEmpty)
            }
            .onAppear {
                isEditing = .inactive
                viewModel.fetchBookmarkedArticles()
            }
            .navigationTitle("Bookmarks")
            .toolbar {
                EditButton()
                    .disabled(viewModel.bookmarkedArticles.isEmpty)
            }
            .environment(\.editMode, $isEditing)
        }
    }
    
        private func deleteArticle(at offsets: IndexSet) {
            for index in offsets {
                let articleToDelete = viewModel.bookmarkedArticles[index]
                viewModel.removeBookmark(articleToDelete)
            }
            
        }
}
#Preview {
    let viewModel = NewsViewModel()
    
    viewModel.articles = [
        NewsArticle(id: UUID(), title: "Sample News 1", description: "This is a sample description 1", url: "https://example.com", urlToImage: nil),
        NewsArticle(id: UUID(), title: "Sample News 2", description: "This is a sample description 2", url: "https://example.com", urlToImage: nil)
    ]
    
    return BookmarksView(viewModel: viewModel)
}

