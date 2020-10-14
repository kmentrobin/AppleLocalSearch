//
//  ContentView.swift
//  Shared
//
//  Created by Robin Kment on 13.10.2020.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Enter City", text: $viewModel.cityText)
            Divider()
            TextField("Enter Point of interest name", text: $viewModel.poiText)
            Divider()
            Text("Results")
                .font(.title)
            List(viewModel.viewData) { item in
                VStack(alignment: .leading) {
                    Text(item.title)
                    Text(item.subtitle)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top)
        .ignoresSafeArea(edges: .bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
