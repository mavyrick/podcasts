//
//  PodcastsListViewModel.swift
//  podcasts
//
//  Created by Josh Sorokin on 2023. 02. 08..
//

import Foundation

class PodcastsListViewModel: ObservableObject, SearchableListViewModelProtocol {
    
    @Published var items: [Podcast] = []
    // Search input first goes through this published property for the debounce functionality to work.
    @Published var searchInput = ""
        
    // Dependency inversion used here. The view model depends on abstractions of these services, not concretions,
    // so different implementations of the protocols can easily be injected for testing or other purposes.
    private var apiRequestService: APIRequestServiceProtocol
    private var urlGenerator: URLGeneratorProtocol
    
    init(apiRequestService: APIRequestServiceProtocol, urlGenerator: URLGeneratorProtocol) {
        self.apiRequestService = apiRequestService
        self.urlGenerator = urlGenerator
    }
    
    func search(searchTerm: String) {
        // It would be nice if pagination were possible with the iTunes API instead of relying on a set limit of items,
        // then new data could be fetched from the API when the list is scrolled to the bottom.
        // I didn't see any support for this functionality in the API documentation.
        let urlString = urlGenerator.generateSearchURLString(term: searchTerm, limit: 100, entity: ITunesSearchEntity.podcast)
        // Grand central dispatch async queue is used for API request and set to user interactive as the
        // use of the search bar is a high priority UI-related task.
        DispatchQueue.global(qos: .userInteractive).async {
            self.fetchData(urlString: urlString)
        }
    }
    
    func fetchData(urlString: String) {
        // PodcastsResults is passed into the generic type for the function.
        apiRequestService.getData(for: urlString) { (result: Result<PodcastsResults, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let podcastsResults):
                    self.items = podcastsResults.results
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
}
