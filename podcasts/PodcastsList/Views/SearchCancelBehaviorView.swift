//
//  SearchCancelBehaviorView.swift
//  podcasts
//
//  Created by Josh Sorokin on 2023. 02. 11..
//

import SwiftUI

struct SearchCancelBehaviorView: View {
    
//  Declared as @ObservedObject because it is coming from a @StateObject in another view.
    @ObservedObject private var viewModel: PodcastsListViewModel
    
    @Environment(\.isSearching) var isSearching
    
    init(viewModel: PodcastsListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("")
            .onChange(of: isSearching) { newValue in
                if !newValue {
                    viewModel.search(searchTerm: "podcasts")
                }
            }
            .hidden()
    }
}
