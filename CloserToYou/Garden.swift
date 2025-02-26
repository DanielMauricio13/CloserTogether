//
//  Garden.swift
//  CloserToYou
//
//  Created by Daniel Pinilla on 2/14/25.
//

import SwiftUI

struct Garden: View {
    var body: some View {
        ZStack{
            Rectangle().foregroundColor(.black).ignoresSafeArea()
            Image("table").renderingMode(.original).resizable()
        }
    }
}

#Preview {
    Garden()
}
