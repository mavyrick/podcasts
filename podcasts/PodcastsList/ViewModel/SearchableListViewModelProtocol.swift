//
//  SearchableListViewModelProtocol.swift
//  podcasts
//
//  Created by Josh Sorokin on 2023. 02. 08..
//

protocol SearchableListViewModelProtocol {
    // Associated type to allow for any model type to be used in the view model implementation.
    associatedtype Item
    var items: [Item] { get }
    func search(searchTerm: String)
    func fetchData(urlString: String)
}
