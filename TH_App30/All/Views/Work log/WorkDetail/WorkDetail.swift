//
//  WorkDetail.swift
//  TH_App30
//
//  Created by IGOR on 06/02/2025.
//

import SwiftUI

struct WorkDetail: View {

    @StateObject var viewModel: WorkViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Work log item")
                        .foregroundColor(.black)
                        .font(.system(size: 23, weight: .regular))
                    
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
                        
                        Button(action: {
                
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = true
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark.circle")
                                .foregroundColor(Color.red)
                                .font(.system(size: 18, weight: .medium))
                        })

                    }
                }
                .padding(.bottom, 30)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: 18) {
                        
                        Text(viewModel.selectedWork?.woClient ?? "")
                            .foregroundColor(.black)
                            .font(.system(size: 22, weight: .regular))
                        
                        HStack {
                            
                            Text((viewModel.selectedWork?.woDate ?? Date()).convertDate(format: "MMM dd, YYYY"))
                                .foregroundColor(.gray)
                                .font(.system(size: 16, weight: .regular))
                            
                            Text((viewModel.selectedWork?.woTime ?? Date()).convertDate(format: "HH:MM"))
                                .foregroundColor(.gray)
                                .font(.system(size: 16, weight: .regular))
                        }
                        
                        Text("\(Text(viewModel.selectedWork?.woIncome ?? "")) $")
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .regular))
                        
                        Text("Services: \(Text(viewModel.selectedWork?.woServ ?? "").foregroundColor(.black).font(.system(size: 16, weight: .regular)))")
                            .foregroundColor(.gray)
                            .font(.system(size: 15, weight: .regular))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
        }
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

                    Text("Delete \(viewModel.selectedWork?.woClient ?? "")?")
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
                            
                            viewModel.totalIncome -= Int(viewModel.selectedWork?.woIncome ?? "") ?? 0
                            
                            CoreDataStack.shared.deleteWork(withWoClient: viewModel.selectedWork?.woClient ?? "", completion: {
                                
                                viewModel.fetchWorks()
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
    }
}

#Preview {
    WorkDetail(viewModel: WorkViewModel())
}
