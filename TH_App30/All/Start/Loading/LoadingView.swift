//
//  LoadingView.swift
//  TH_App30
//
//  Created by IGOR on 05/02/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 140)
            }
            
            VStack {
                
                Spacer()
                
                ProgressView()
                    .padding(.bottom, 90)
            }
        }
    }
}

#Preview {
    LoadingView()
}
