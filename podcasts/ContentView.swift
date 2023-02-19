//
//  ContentView.swift
//  podcasts
//
//  Created by Josh Sorokin on 2023. 02. 08..
//

import SwiftUI

// The deployment target is set to iOS 16.1 (the latest).
// If this app was for a wider audience the target should probably be set lower.
struct ContentView: View {
    var body: some View {
        // Use of dependency injection for view model
        PodcastsListView(
            viewModel: PodcastsListViewModel(
                apiRequestService: APIRequestService(),
                urlGenerator: ITunesURLGenerator()
            )
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
