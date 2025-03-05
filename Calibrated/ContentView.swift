//
//  ContentView.swift
//  Calibrated
//
//  Created by Christos Kaktsis on 4/3/25.
//

import SwiftUI

struct ContentView: View {
    
    let colors: [Color] = [.purple, .pink, .orange]
    var body: some View {
        NavigationStack {
            List(colors, id: \.self) { color in
                NavigationLink(destination: ColorDetail(color: color)){
                    Text(color.description)
                }
                
            }
            .navigationTitle("Pick a Color")
        }
    }
}

#Preview {
    ContentView()
}


struct ColorDetail: View {
    let color: Color
    
    var body: some View {
        Text(color.description)
    }
}
