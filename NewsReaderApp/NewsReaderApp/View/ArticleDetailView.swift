//
//  ArticleDetailView.swift
//  NewsReaderApp
//
//  Created by Jeetendra on 14/09/24.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: NewsArticle
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        VStack {
            AsyncImageView(urlToImage: article.urlToImage, width: 300, height: 250, cornerRadius: 20)
            
            Text(article.title)
                .font(.headline)
                .padding()
            
            Text(article.description ?? "No additional information available")
                .padding()
            
            Spacer()
            
            Button(action: {
                if let url = URL(string: article.url) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Read Full Article")
                    .foregroundColor(.blue)
                    .underline()
            }
            .padding()
            
            Button(action: {
                viewModel.bookmarkArticle(article)
            }) {
                Text("Bookmark")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationBarTitle("Article Detail", displayMode: .inline)
    }
}
#Preview {
    let sampleArticle = NewsArticle(
        id: UUID(),
        title: "Sample News Title",
        description: "This is a sample news description.",
        url: "https://example.com",
        urlToImage: nil
    )
    
    let viewModel = NewsViewModel()
    
    return ArticleDetailView(article: sampleArticle, viewModel: viewModel)
}

