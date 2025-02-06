//
//  AddClient.swift
//  TH_App30
//
//  Created by IGOR on 05/02/2025.
//

import SwiftUI

struct AddClient: View {
    
    @StateObject var viewModel: ClientsViewModel
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New client")
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
                            
                            viewModel.clSkin = viewModel.currentSkin
                            
                            viewModel.addClient()
                            
                            viewModel.clNum = ""
                            viewModel.clName = ""
                            viewModel.clDetail = ""
                            viewModel.currentSkin = ""
                            
                            viewModel.fetchClients()
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = false
                            }
                            
                        }, label: {
                            
                            Text("Add")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 17, weight: .medium))
                        })
                        .opacity(viewModel.clName.isEmpty || viewModel.clNum.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.clName.isEmpty || viewModel.clNum.isEmpty ? true : false)
                    }
                }
                .padding(.bottom, 30)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 14) {
                        
                        Text("Name")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                        
                        ZStack(content: {
                            
                            Text("Client name")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                                .opacity(viewModel.clName.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.clName)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 3).fill(.gray.opacity(0.1)))
                        
                        Text("Phone number")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                        
                        ZStack(content: {
                            
                            Text("+0 (000) 000–0000")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                                .opacity(viewModel.clNum.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.clNum)
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 3).fill(.gray.opacity(0.1)))
                        
                        Text("Skin type")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                        
                        Menu(content: {
                            
                            ForEach(viewModel.skins, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.currentSkin = index
                                    
                                }, label: {
                                    
                                    Text(index)
                                })
                            }
                            
                        }, label: {
                            
                            if viewModel.currentSkin.isEmpty {
                                
                                HStack {
                                    
                                    Text("Select skin type")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 15, weight: .regular))
                                    
                                    Spacer()
                                 
                                    Image(systemName: "chevron.up.chevron.down")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 15, weight: .regular))
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(RoundedRectangle(cornerRadius: 3).fill(.gray.opacity(0.1)))
                                
                            } else {
                                
                                HStack {
                                    
                                    Text(viewModel.currentSkin)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 16, weight: .regular))
                                    
                                    Spacer()
                                 
                                    Image(systemName: "chevron.up.chevron.down")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 15, weight: .regular))
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(RoundedRectangle(cornerRadius: 3).fill(.gray.opacity(0.1)))
                            }
                        })
                        
                        Text("Client details")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                        
                        ZStack(content: {
                            
                            Text("Enter client details")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                                .opacity(viewModel.clDetail.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.clDetail)
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
    AddClient(viewModel: ClientsViewModel())
}
