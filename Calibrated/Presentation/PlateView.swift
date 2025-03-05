//
//  PlateView.swift
//  Calibrated
//
//  Created by Christos Kaktsis on 4/3/25.
//

import SwiftUI
enum PlateViewType {
    case side
    case face
}

struct PlateView: View {
    let plate: Plate
    let viewType: PlateViewType
    var isDisabled: Bool = false
    var body: some View {
        switch viewType {
        case .side:
            Text(plate.formattedWeight)
                .fontWidth(.compressed)
                .foregroundStyle(plate.fontColor)
                .frame(width: 25, height: plate.height)
                .border(Color.black)
                .background(plate.color)
                .cornerRadius(7)
        case .face:
            ZStack {
                Circle()
                    .stroke(.black, lineWidth: 2)
                    .fill(plate.color)
                    .frame(width: 50, height: 50)
                Text(plate.formattedWeight)
                    .font(.headline)
                    .fontWidth(.compressed)
                    .foregroundStyle(plate.fontColor)
                
            }
            .opacity(isDisabled ? 0.4 : 1.0)
            .grayscale(isDisabled ? 0.2 : 0.0)
        }
        
    }
}

#Preview {
    PlateView(plate: Plate(weight: 20), viewType: .face, isDisabled: true)
}
