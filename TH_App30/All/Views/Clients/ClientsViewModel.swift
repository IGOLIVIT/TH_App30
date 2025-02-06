//
//  ClientsViewModel.swift
//  TH_App30
//
//  Created by IGOR on 05/02/2025.
//

import SwiftUI
import CoreData

final class ClientsViewModel: ObservableObject {
    
    @Published var skins: [String] = ["Oily", "Dry", "Combination", "Sensitive"]
    @Published var currentSkin = ""

    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isSettings: Bool = false
    @Published var isDetail: Bool = false

    @Published var clName: String = ""
    @Published var clSkin: String = ""
    @Published var clNum: String = ""
    @Published var clDetail: String = ""

    @Published var clients: [ClientModel] = []
    @Published var selectedClient: ClientModel?

    func addClient() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "ClientModel", into: context) as! ClientModel

        loan.clName = clName
        loan.clSkin = clSkin
        loan.clNum = clNum
        loan.clDetail = clDetail

        CoreDataStack.shared.saveContext()
    }

    func fetchClients() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ClientModel>(entityName: "ClientModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.clients = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.clients = []
        }
    }

}
