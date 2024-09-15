//
//  NewsListView.swift
//  NewsReaderApp
//
//  Created by Jeetendra on 14/09/24.
//

import SwiftUI

struct NewsListView: View {
    @ObservedObject var viewModel = NewsViewModel()
    @State private var selectedCategory = "general"
    
    let categories = ["general", "business", "technology", "sports", "health"]
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category.capitalized).tag(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: selectedCategory) {
                    viewModel.fetchNews(category: selectedCategory)
                }
                
                List(viewModel.articles) { article in
                    NavigationLink(destination: ArticleDetailView(article: article, viewModel: viewModel)) {
                        VStack(alignment: .leading) {
                            HStack(alignment: .top, spacing: 10) {
                                AsyncImageView(urlToImage: article.urlToImage, width: 60, height: 60, cornerRadius: 8)
                                Text(article.title)
                                    .font(.headline)
                            }
                            Text(article.description ?? "No description available")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("News Reader")
            .onAppear {
                viewModel.fetchNews()
            }
        }
    }
}

#Preview {
    NewsListView()
}
