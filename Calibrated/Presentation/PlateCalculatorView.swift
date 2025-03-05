//
//  PlateCalculatorView.swift
//  Calibrated
//
//  Created by Christos Kaktsis on 4/3/25.
//

import SwiftUI

struct PlateCalculatorView: View {
    @ObservedObject var viewModel = ViewModel()
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        VStack {
            ZStack {
                BarView()
                HStack(spacing: 2) {
                    PlatesStackView(plates: viewModel.platesOnBar)
                    Spacer()
                }
                .padding(.horizontal, 27)
            }
            .padding(.top, 50)
            
            Spacer()
            Divider()
                .padding()
            VStack(alignment: .leading) {
                
                Text("Select available plates")
                    .padding(.horizontal)
                ScrollView(.horizontal) {
                    HStack{
                        ForEach(viewModel.plates) { plate in
                            PlateView(
                                plate: plate,
                                viewType: .face,
                                isDisabled: viewModel.disabledPlates[plate] ?? false)
                            .onTapGesture {
                                viewModel.togglePlate(plate)
                            }
                        }
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)
                
            }
            Button("Calculate") {
                viewModel.setPlatesOnTheBar(workingWeight: 145)
            }
            .padding()
        }
    }
}

struct PlatesStackView: View {
    let plates: [Plate: Int]
    var body: some View {
        HStack(spacing: 2) {
            ForEach(plates.sorted(by: { $0.key.weight > $1.key.weight }), id: \.key) { key, value in
                ForEach(0..<value, id: \.self) { _ in
                    PlateView(plate: key, viewType: .side)
                }
            }
        }
    }
}
extension PlateCalculatorView {
    class ViewModel: ObservableObject {
        var plates: [Plate] = Plate.allPlates
        let barWeight = 20.0
        @Published var platesOnBar: [Plate:Int] = [:]
        @Published var disabledPlates: [Plate: Bool] = [:]
        
        init() {
            // Ensure all plates are enabled by default
            for plate in Plate.allPlates {
                disabledPlates[plate] = plate.weight == 50 ? true : false
            }
        }
        func setPlatesOnTheBar(workingWeight: Double) {
            platesOnBar = [:]
            var weightOnBar = (workingWeight - barWeight)/2
            for plate in enabledPlates() {
                let div = weightOnBar/plate.weight
                weightOnBar = weightOnBar.truncatingRemainder(dividingBy: plate.weight)
                let numberOfPlates = Int(div.rounded(.down))
                if numberOfPlates > 0 {
                    platesOnBar[plate] = numberOfPlates
                }
                
            }
        }
        
        func togglePlate(_ plate: Plate) {
            disabledPlates[plate] = !(disabledPlates[plate] ?? false)
        }
        
        func enabledPlates() -> [Plate] {
            return plates.filter { disabledPlates[$0] != true }
        }
        
    }
}
#Preview {
    PlateCalculatorView()
}
