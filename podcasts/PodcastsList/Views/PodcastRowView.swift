//
//  PodcastRowView.swift
//  podcasts
//
//  Created by Josh Sorokin on 2023. 02. 08..
//

import SwiftUI

struct PodcastRowView: View {
    
    @Binding var podcast: Podcast
    
    var body: some View {
        HStack() {
            // AsyncImage is still causing some unresolved issues.
            // There are occasssions where the image loading process doesn't complete and the spinner persists.
            // This usually occurs when the list is scrolled very fast.
            AsyncImage(url: URL(string: podcast.artworkURL100 ?? ""), content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }, placeholder: {
                // Add a spinner while the image is loading
                ProgressView()
            })
            .frame(width: 75, height: 75)
            .cornerRadius(5.0)
            VStack(spacing: 5) {
                Text(podcast.artistName)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14, weight: .bold))
                Text(podcast.trackName)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 14))
            }
            Spacer()
        }
        .frame(width: 290)
    }
}
