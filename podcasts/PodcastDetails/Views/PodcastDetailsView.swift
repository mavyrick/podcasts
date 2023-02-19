//
//  PodcastDetailsView.swift
//  podcasts
//
//  Created by Josh Sorokin on 2023. 02. 08..
//

import SwiftUI

struct PodcastDetailsView: View {
    
    @Binding var podcast: Podcast
    
    var body: some View {
        VStack(spacing: 25) {
            // A placeholder is still needed for the rare case of when an artwork image isn't available.
            AsyncImage(url: URL(string: podcast.artworkURL600 ?? ""), content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }, placeholder: {
                ProgressView()
            })
            .frame(width: 300, height: 300)
            .cornerRadius(5.0)
            Text(podcast.artistName)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                .font(.system(size: 22, weight: .bold))
            Text("\(podcast.trackName)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 18))
            // If there is no release date "Release date not available" will be displayed.
            Text("RELEASE DATE: \(podcast.releaseDate?.toFormattedDate() ?? "Release date not available")")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 15)
                .font(.system(size: 15))
            HStack {
                Spacer()
                Link("Go to podcast \(Image(systemName: "chevron.right"))", destination: URL(string: podcast.trackViewURL)!)
                    .font(.system(size: 18))
            }
            Spacer()
        }
        .padding(.top, 25)
        .padding(.leading, 15)
        .padding(.trailing, 15)
    }
}
