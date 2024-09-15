//
//  AsyncImageView.swift
//  NewsReaderApp
//
//  Created by manku on 15/09/24.
//

import SwiftUI

struct AsyncImageView: View {
    let urlToImage: String?
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat

    var body: some View {
        if let urlToImage = urlToImage, let imageUrl = URL(string: urlToImage) {
            AsyncImage(url: imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: width, height: height)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width, height: height)
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            // Placeholder for when there's no image
            Image(systemName: "photo")
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
    }
}

#Preview {
    VStack {
        // Preview with an actual image URL
        AsyncImageView(
            urlToImage: "https://via.placeholder.com/150",
            width: 100,
            height: 100,
            cornerRadius: 8
        )
        .previewDisplayName("With Image URL")
        
        // Preview without an image URL (uses placeholder)
        AsyncImageView(
            urlToImage: nil,
            width: 100,
            height: 100,
            cornerRadius: 8
            
        )
        .previewDisplayName("Without Image URL")
    }
}
