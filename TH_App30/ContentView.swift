//
//  ContentView.swift
//  TH_App30
//
//  Created by IGOR on 05/02/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var current_tab: Tab = Tab.Clients

    @AppStorage("status") var status: Bool = false
    
    init() {
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack {
            
            Color.white
                .ignoresSafeArea()
            
            if status {
            
            VStack(spacing: 0, content: {
            
                    TabView(selection: $current_tab, content: {

                        ClientsView()
                            .tag(Tab.Clients)
                        
                        ServicesView()
                            .tag(Tab.Services)

                        WorkView()
                            .tag(Tab.Work)
                        
                    })
                    
                    TabBar(selectedTab: $current_tab)
                })
                    .ignoresSafeArea(.all, edges: .bottom)
                    .onAppear {
                        
                    }
                
            } else {
                
                OB1()
            }
        }
    }
}

#Preview {
    ContentView()
}
