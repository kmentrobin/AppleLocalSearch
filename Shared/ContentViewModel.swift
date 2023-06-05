//
//  ContentViewModel.swift
//  AppleLocalSearch
//
//  Created by Robin Kment on 13.10.2020.
//

import Foundation
import MapKit
import Combine

struct LocalSearchViewData: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    
    init(mapItem: MKMapItem) {
        self.title = mapItem.name ?? ""
        self.subtitle = mapItem.placemark.title ?? ""
    }
}

final class ContentViewModel: ObservableObject {
    private var cancellable: AnyCancellable?
    
    @Published var cityText = "" {
        didSet {
            if oldValue != cityText {
                searchForCity(text: cityText)
            }
        }
    }
    
    @Published var poiText = "" {
        didSet {
            if oldValue != poiText {
                poiText(text: poiText)
            }
        }
    }
    
    @Published var viewData = [LocalSearchViewData]()

    var service: LocalSearchService
    
    init() {
        let center = CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)             // New York
        service = LocalSearchService(in: center)
        
        cancellable = service.localSearchPublisher.sink { mapItems in
            self.viewData = mapItems.map({ LocalSearchViewData(mapItem: $0) })
        }
    }
    
    private func searchForCity(text: String) {
        service.searchCities(searchText: text)
    }
    
    private func searchForPOI(text: String) {
        service.searchPointOfInterests(searchText: text)
    }
}
