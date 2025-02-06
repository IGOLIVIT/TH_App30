//
//  OB1.swift
//  TH_App30
//
//  Created by IGOR on 05/02/2025.
//

import SwiftUI

struct OB1: View {
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Image("ob1")
                        .resizable()
                        .ignoresSafeArea()
                 
                    VStack {
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 18) {
                            
                           Text("Welcome to GlamUp Pro!")
                                .foregroundColor(.white)
                                .font(.system(size: 28, weight: .semibold))
                            
                            Text("Add clients, services, and track your income!")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .regular))
                            
                            Spacer()
                            
                            NavigationLink(destination: {
                                
                                OB2()
                                    .navigationBarBackButtonHidden()
                                
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
    OB1()
}
