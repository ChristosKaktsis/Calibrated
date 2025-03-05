//
//  Plate.swift
//  Calibrated
//
//  Created by Christos Kaktsis on 4/3/25.
//

import Foundation
import SwiftUI

struct Plate: Identifiable, Hashable {
    let id: UUID = UUID()
    let weight: Double
    var color: Color {
        switch weight {
        case 25:
            Color.red
        case 20:
            Color.blue
        case 15:
            Color.yellow
        case 10:
            Color.green
        case 5:
            Color.white
        case 2.5, 50:
            Color.black
        default:
            Color.gray
        }
    }
    
    var height: CGFloat {
        switch weight {
        case 50, 25, 20: return 250
        case 15: return 210
        case 10: return 200
        case 5: return 150
        case 2.5: return 130
        default: return 100
        }
    }
    
    var formattedWeight: String {
        switch weight {
        case 2.5, 1.5, 0.5:
            String(format: "%.1f kg", weight)
        case 1.25:
            String(format: "%.2f kg", weight)
        default:
            String(format: "%.0f kg", weight)
        }
    }
    
    var fontColor: Color {
        switch weight {
        case 5:
            Color.black
        default:
            Color.white
        }
    }
}

extension Plate {
    static let allPlates: [Plate] =
    [
        Plate(weight: 50),
        Plate(weight: 25),
        Plate(weight: 20),
        Plate(weight: 15),
        Plate(weight: 10),
        Plate(weight: 5),
        Plate(weight: 2.5),
        Plate(weight: 1.5),
        Plate(weight: 1.25),
        Plate(weight: 0.5),
        
    ]
    
}
