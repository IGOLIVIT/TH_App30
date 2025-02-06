//
//  SettingsView.swift
//  TH_App30
//
//  Created by IGOR on 06/02/2025.
//

import SwiftUI
import StoreKit

struct SettingsView: View {

    @Environment(\.presentationMode) var router
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    VStack {
                        
                        Text("Settings")
                            .foregroundColor(.black)
                            .font(.system(size: 23, weight: .regular))
                     
                        Rectangle()
                            .fill(.gray.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                    }
                    
                    HStack {
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                router.wrappedValue.dismiss()
                            }
                            
                        }, label: {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .font(.system(size: 17, weight: .medium))
                        })
                        
                        Spacer()

                    }
                }
                .padding(.bottom, 30)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 18) {
                     
                        HStack {
                            
                            Button(action: {
                                
                                SKStoreReviewController.requestReview()
                                
                            }, label: {
                                
                                VStack(alignment: .leading, spacing: 18) {
                                    
                                    Text("Rate the app")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .regular))
                                        .frame(width: 80, alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                    
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color("prim"))
                                        .font(.system(size: 18, weight: .regular))
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                            })
                            
                            Button(action: {

                                guard let url = URL(string: "https://www.termsfeed.com/live/2b704b20-e8f4-486e-8fba-80bbeff1e91a") else { return }
                                
                                UIApplication.shared.open(url)
                                
                            }, label: {
                                
                                VStack(alignment: .leading, spacing: 18) {
                                    
                                    Text("Usage policy")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .regular))
                                        .frame(width: 80, alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                    
                                    Image(systemName: "menucard.fill")
                                        .foregroundColor(Color("prim"))
                                        .font(.system(size: 18, weight: .regular))
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                            })
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    SettingsView()
}
