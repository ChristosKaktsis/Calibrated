//
//  PlateCalculatorView.swift
//  Calibrated
//
//  Created by Christos Kaktsis on 4/3/25.
//

import SwiftUI

struct PlateCalculatorView: View {
    @ObservedObject var viewModel = ViewModel()
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
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            Divider()
                
            HStack {
                Text("Set weight")
                TextField("Enter weight", value: $viewModel.workingWeight, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .padding(.leading, 55.0)
                
            }
            .padding()
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Select bar weight")
                Picker("Hello", selection: $viewModel.barWeight) {
                    ForEach(viewModel.bars, id: \.self) { bar in
                        Text(Int(bar).description)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding()
            
            Divider()
              
            
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
                if let weight = viewModel.workingWeight {
                    viewModel.setPlatesOnTheBar(workingWeight: weight)
                }
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
        @Published var barWeight = 20.0
        let bars: [Double] = [32.0, 25.0, 20.0, 15.0, 10.0, 5.0]
        @Published var platesOnBar: [Plate:Int] = [:]
        @Published var disabledPlates: [Plate: Bool] = [:]
        @Published var workingWeight: Double?
        
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
