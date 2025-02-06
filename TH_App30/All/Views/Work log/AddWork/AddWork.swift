//
//  AddWork.swift
//  TH_App30
//
//  Created by IGOR on 06/02/2025.
//

import SwiftUI

struct AddWork: View {

    @StateObject var viewModel: WorkViewModel
    @StateObject var mainModel = ClientsViewModel()
    @StateObject var thirdModel = ServicesViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New work log item")
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
                            
                            viewModel.totalIncome += viewModel.addingIncome
                            
                            viewModel.woClient = mainModel.selectedClient?.clName ?? ""
                            viewModel.woIncome = thirdModel.selectedService?.serPrice ?? ""
                            viewModel.woServ = thirdModel.selectedService?.serName ?? ""
                            
                            viewModel.addWork()
                            
                            viewModel.woServ = ""
                            viewModel.woClient = ""
                            viewModel.addingIncome = 0
                            viewModel.woServ = ""
                            
                            viewModel.fetchWorks()
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = false
                            }
                            
                        }, label: {
                            
                            Text("Add")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 17, weight: .medium))
                        })
                    }
                }
                .padding(.bottom, 30)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 18) {
                        
                        Text("Client")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            LazyVStack(spacing: 15) {
                                
                                ForEach(mainModel.clients, id: \.self) { index in
                                    
                                    Button(action: {
                                        
                                        mainModel.selectedClient = index
                                        
                                    }, label: {
                                        
                                        VStack {
                                            
                                            HStack {
                                                
                                                Text(index.clName ?? "")
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 15, weight: .regular))
                                                
                                                Spacer()
                                                
                                                ZStack {
                                                    
                                                    Circle()
                                                        .stroke(Color.gray.opacity(0.6), lineWidth: 2)
                                                        .frame(width: 15, height: 15)
                                                    
                                                    Image(systemName: "checkmark")
                                                        .foregroundColor(.black.opacity(0.6))
                                                        .font(.system(size: 11, weight: .medium))
                                                        .opacity(mainModel.selectedClient == index ? 1 : 0)
                                                }
                                                .padding(1)
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
                        .padding()
                        .frame(height: 220)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                        
                        Text("Service")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            LazyVStack(spacing: 15) {
                                
                                ForEach(thirdModel.services, id: \.self) { index in
                                    
                                    Button(action: {
                                        
                                        thirdModel.selectedService = index
                                        
                                        viewModel.addingIncome += Int(thirdModel.selectedService?.serPrice ?? "") ?? 0
                                        
                                    }, label: {
                                        
                                        VStack {
                                            
                                            HStack {
                                                
                                                Text(index.serName ?? "")
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 15, weight: .regular))
                                                
                                                Spacer()
                                                
                                                ZStack {
                                                    
                                                    Circle()
                                                        .stroke(Color.gray.opacity(0.6), lineWidth: 2)
                                                        .frame(width: 15, height: 15)
                                                    
                                                    Image(systemName: "checkmark")
                                                        .foregroundColor(.black.opacity(0.6))
                                                        .font(.system(size: 11, weight: .medium))
                                                        .opacity(thirdModel.selectedService == index ? 1 : 0)
                                                }
                                                .padding(1)
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
                        .padding()
                        .frame(height: 220)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                        
                        Text("Date&Time")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                        
                        HStack {
                            
                            DatePicker("", selection: $viewModel.woDate, displayedComponents: .date)
                                .labelsHidden()
                            
                            DatePicker("", selection: $viewModel.woTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                        }
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text("Income")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .regular))
                            
                            Text("\(viewModel.addingIncome) $")
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .regular))
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
        }
        .onAppear {
            
            mainModel.fetchClients()
        }
        .onAppear {
            
            thirdModel.fetchServices()
        }
    }
}

#Preview {
    AddWork(viewModel: WorkViewModel())
}
