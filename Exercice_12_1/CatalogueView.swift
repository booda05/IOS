//
//  ContentView.swift
//  Exercice_12_1
//
//  Created by user230518 on 3/22/23.
//

import SwiftUI

struct CatalogueView: View {
    private var catalogue = Catalogue()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach (0..<catalogue.compte, id: \.self) { i in
                    NavigationLink(value: i) {
                        HStack {
                            CelluleView(nom: catalogue[i].nom, code: catalogue[i].code)
                        }
                    }
                }
            }
            .navigationDestination(for: Int.self) { i in
                AeroportView(aéroport: catalogue[i])
            }
            .navigationTitle("Aéroports du Monde")
        }
    }
}

struct CatalogueView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogueView()
    }
}
