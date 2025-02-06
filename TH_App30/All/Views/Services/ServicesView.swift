//
//  ServicesView.swift
//  TH_App30
//
//  Created by IGOR on 05/02/2025.
//

import SwiftUI

struct ServicesView: View {

    @StateObject var viewModel = ServicesViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isSettings = true
                    }
                    
                }, label: {
                    
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.black)
                        .font(.system(size: 17, weight: .regular))
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text("Services")
                    .foregroundColor(.black)
                    .font(.system(size: 28, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 20)

                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = true
                    }
                    
                }, label: {
                    
                    Text("\(Image(systemName: "plus.circle")) Add service")
                        .foregroundColor(Color("prim"))
                        .font(.system(size: 16, weight: .regular))
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)

                if viewModel.services.isEmpty {
                    
                    VStack {
                        
                        Image("ems")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                        
                        Text("The service list is empty.")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .regular))
                    }
                    .frame(maxHeight: .infinity)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.services, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.selectedService = index
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isDetail = true
                                    }
                                    
                                }, label: {
                                    
                                    VStack {
                                        
                                        HStack {
                                            
                                            VStack(alignment: .leading, spacing: 17) {
                                                
                                                Text(index.serName ?? "")
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 22, weight: .regular))
                                                
                                                Text("\(index.serPrice ?? "") $")
                                                    .foregroundColor(.black.opacity(0.6))
                                                    .font(.system(size: 18, weight: .regular))
                                            }
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                
                                                viewModel.selectedService = index
                                                
                                                withAnimation(.spring()) {
                                                    
                                                    viewModel.isDelete = true
                                                }
                                                
                                            }, label: {
                                                
                                                Image(systemName: "xmark.circle")
                                                    .foregroundColor(Color.red)
                                                    .font(.system(size: 18, weight: .medium))
                                            })
                                        }
                                        
                                        Rectangle()
                                            .fill(.gray.opacity(0.5))
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 1)
                                    }
                                })
                            }
                        }
                    }
                }
                
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchServices()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddService(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            ServiceDetail(viewModel: viewModel)
        })
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isDelete ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                    }
                
                VStack(spacing: 15) {

                    Text("Delete \(viewModel.selectedService?.serName ?? "")?")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .padding(.vertical)

                    Rectangle()
                        .fill(.black.opacity(0.2))
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                    
                    HStack {
                        
                        Button(action: {
                            
                            CoreDataStack.shared.deleteService(withSerName: viewModel.selectedService?.serName ?? "", completion: {
                                
                                viewModel.fetchServices()
                            })
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                                viewModel.isDetail = false
                            }
                            
                        }, label: {
                            
                            Text("Delete")
                                .foregroundColor(.red)
                                .font(.system(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                            
                        })
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Text("Cancel")
                                .foregroundColor(.black)
                                .font(.system(size: 17, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                            
                        })
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg")))
                .padding()
                .offset(y: viewModel.isDelete ? 0 : UIScreen.main.bounds.height)
            }
        )
        .sheet(isPresented: $viewModel.isSettings, content: {
            
            SettingsView()
        })
    }
}

#Preview {
    ServicesView()
}
