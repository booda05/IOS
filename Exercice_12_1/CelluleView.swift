//
//  CelluleView.swift
//  Exercice_12_1
//
//  Created by user230518 on 3/22/23.
//

import SwiftUI

struct CelluleView: View {
    var nom: String
    var code: String
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("\(code)")
                    .monospaced()
                    .frame(width: 45, alignment: .trailing)
            }
            
            VStack(alignment: .leading) {
                Text("\(nom)")
                    .monospaced()
            }
            Spacer()
        }
    }
}

struct CelluleView_Previews: PreviewProvider {
    static var previews: some View {
        CelluleView(nom: "Pierre-Éliot Trudeau", code: "YUL")
    }
}
