//
//  PodcastsListView.swift
//  podcasts
//
//  Created by Josh Sorokin on 2023. 02. 08..
//

import SwiftUI

struct PodcastsListView: View {
    
    @StateObject private var viewModel: PodcastsListViewModel
    
    @State private var searchText = ""
    
    @Environment(\.dismissSearch) private var dismissSearch
    
    // Would have liked to inject the view model as a protocol type (SearchableListViewModelProtocol),
    // but this is a more complicated ordeal when using @StateObject.
    init(viewModel: PodcastsListViewModel) {
        // The view model is assigned as a @StateObject here.
        // This is better than @ObservedObject because it prevents the instance from being possibly destroyed when the view updates.
        // When this object is shared with other views it should be declared as @ObservedObject in those views.
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    func performSearch() {
        viewModel.search(searchTerm: searchText)
    }
    
    var body: some View {
        // I would have used NavigationStack as it is newer, but it was causing some glitches between transitions.
        NavigationView {
            if viewModel.items.count == 0 && searchText.count > 0 {
                NoResultsView()
            } else {
                List($viewModel.items, id: \.trackID) { $podcast in
                    NavigationLink(destination: PodcastDetailsView(podcast: $podcast)
                        .navigationTitle("Podcast Details")
                        .navigationBarTitleDisplayMode(.inline)) {
                            PodcastRowView(podcast: $podcast)
                        }
                }
                .navigationTitle("Podcasts")
            }
            // For the search cancel button behavior to work it needs to be implemented in a child view.
            SearchCancelBehaviorView(viewModel: viewModel)
        }
        .onAppear() {
            // These results are what the user sees when the app initially loads.
            // Perhaps a recommendation engine would be more appropriate to populate the List on appear,
            // but for now popular "podcasts" that the Apple API provides are being displayed.
            viewModel.search(searchTerm: "podcasts")
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for podcasts")
        .onSubmit(of: .search, performSearch)
        .onChange(of: searchText) { _ in
            viewModel.searchInput = searchText
        }
        .onReceive(
            // Debounces search requests every 0.5 seconds an API request isn't made every searchText change.
            viewModel.$searchInput.debounce(for: 0.5, scheduler: RunLoop.main)
        ) { _ in
            if searchText.count > 0 {
                performSearch()
            }
        }
    }
}
