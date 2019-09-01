//
//  SearchView.swift
//  FoodTrucksEx
//
//  Created by Hai Nguyen on 8/31/19.
//  Copyright © 2019 Hai Nguyen. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
