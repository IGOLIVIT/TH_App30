//
//  OB3.swift
//  TH_App30
//
//  Created by IGOR on 05/02/2025.
//

import SwiftUI

struct OB3: View {
    
    @AppStorage("status") var status: Bool = false
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Image("ob3")
                        .resizable()
                        .ignoresSafeArea()
                 
                    VStack {
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 18) {
                            
                           Text("All clients in one place")
                                .foregroundColor(.white)
                                .font(.system(size: 28, weight: .semibold))
                            
                            Text("Easy client information management")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .regular))
                            
                            Spacer()
                            
                            Button(action: {
                                
                                status = true
                                
                            }, label: {
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                                    .font(.system(size: 18, weight: .medium))
                                    .padding(9)
                                    .background(RoundedRectangle(cornerRadius: 4).fill(.white))
                            })
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding()
                        }
                        .padding()
                        .padding(.vertical, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 280)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color("prim")))
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    OB3()
}
