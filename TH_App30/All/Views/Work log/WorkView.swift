//
//  WorkView.swift
//  TH_App30
//
//  Created by IGOR on 05/02/2025.
//

import SwiftUI

struct WorkView: View {

    @StateObject var viewModel = WorkViewModel()
    
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
                
                Text("Work log")
                    .foregroundColor(.black)
                    .font(.system(size: 28, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 20)

                VStack(alignment: .leading, spacing: 17) {
                    
                    Text("Total income")
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .regular))
                    
                    Text("\(viewModel.totalIncome) $")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .regular))
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                .padding(.bottom)
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = true
                    }
                    
                }, label: {
                    
                    Text("\(Image(systemName: "plus.circle")) Add work log item")
                        .foregroundColor(Color("prim"))
                        .font(.system(size: 16, weight: .regular))
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)

                if viewModel.works.isEmpty {
                    
                    VStack {
                        
                        Image("em3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                        
                        Text("The work log is empty.")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .regular))
                    }
                    .frame(maxHeight: .infinity)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.works, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.selectedWork = index
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isDetail = true
                                    }
                                    
                                }, label: {
                                    
                                    VStack {
                                        
                                        HStack {
                                            
                                            VStack(alignment: .leading, spacing: 17) {
                                                
                                                Text(index.woClient ?? "")
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 22, weight: .regular))
                                                
                                                HStack {
                                                    
                                                    Text((index.woDate ?? Date()).convertDate(format: "MMM dd, YYYY"))
                                                        .foregroundColor(.gray)
                                                        .font(.system(size: 16, weight: .regular))
                                                    
                                                    Text((index.woTime ?? Date()).convertDate(format: "HH:MM"))
                                                        .foregroundColor(.gray)
                                                        .font(.system(size: 16, weight: .regular))
                                                }
                                                
                                                Text("\(index.woServ ?? "")")
                                                    .foregroundColor(.black.opacity(0.6))
                                                    .font(.system(size: 18, weight: .regular))
                                                
                                                Text("\(index.woIncome ?? "") $")
                                                    .foregroundColor(.black.opacity(0.6))
                                                    .font(.system(size: 18, weight: .regular))
                                            }
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                
                                                viewModel.selectedWork = index
                                                
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
            
            viewModel.fetchWorks()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddWork(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            WorkDetail(viewModel: viewModel)
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
        .sheet(isPresented: $viewModel.isSettings, content: {
            
            SettingsView()
        })
    }
}

#Preview {
    WorkView()
}
