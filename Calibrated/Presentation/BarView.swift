//
//  BarView.swift
//  Calibrated
//
//  Created by Christos Kaktsis on 5/3/25.
//

import SwiftUI

struct BarView: View {
    var body: some View {
        ZStack{
            HStack{
                Rectangle()
                    .fill(Color.gray)
                    .border(Color.black)
                    .frame(width: 270, height: 20)
                    .cornerRadius(2)
                Spacer()
            }
           
            HStack{
                Rectangle()
                    .fill(Color.gray)
                    .border(Color.black)
                    .frame(width: 10, height: 40)
                    .cornerRadius(2)
                Spacer()
            }
            .padding()
            
        }
        
    }
}

#Preview {
    BarView()
}
