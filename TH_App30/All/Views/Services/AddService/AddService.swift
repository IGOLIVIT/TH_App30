//
//  AddService.swift
//  TH_App30
//
//  Created by IGOR on 06/02/2025.
//

import SwiftUI

struct AddService: View {

    @StateObject var viewModel: ServicesViewModel
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New service")
                        .foregroundColor(.black)
                        .font(.system(size: 23, weight: .regular))
                    
                    HStack {
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .font(.system(size: 17, weight: .medium))
                        })

                        Spacer()
                        
                        Button(action: {
                            
                            viewModel.addService()
                            
                            viewModel.serName = ""
                            viewModel.serProd = ""
                            viewModel.serPrice = ""
                            viewModel.serDescr = ""
                            
                            viewModel.fetchServices()
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = false
                            }
                            
                        }, label: {
                            
                            Text("Add")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 17, weight: .medium))
                        })
                        .opacity(viewModel.serName.isEmpty || viewModel.serPrice.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.serName.isEmpty || viewModel.serPrice.isEmpty ? true : false)
                    }
                }
                .padding(.bottom, 30)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 14) {
                        
                        Text("Name")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                        
                        ZStack(content: {
                            
                            Text("Service name")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                                .opacity(viewModel.serName.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.serName)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 3).fill(.gray.opacity(0.1)))
                        
                        Text("Products used")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                        
                        ZStack(content: {
                            
                            Text("Enter products or tools")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                                .opacity(viewModel.serProd.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.serProd)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 3).fill(.gray.opacity(0.1)))

                        Text("Service description")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                        
                        ZStack(content: {
                            
                            Text("Describe the service")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                                .opacity(viewModel.serDescr.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.serDescr)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 3).fill(.gray.opacity(0.1)))
                        
                        Text("Price")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                        
                        ZStack(content: {
                            
                            Text("0 $")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                                .opacity(viewModel.serPrice.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.serPrice)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 3).fill(.gray.opacity(0.1)))
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    AddService(viewModel: ServicesViewModel())
}
