//
//  ServicesViewModel.swift
//  TH_App30
//
//  Created by IGOR on 05/02/2025.
//

import SwiftUI
import CoreData

final class ServicesViewModel: ObservableObject {

    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isSettings: Bool = false
    @Published var isDetail: Bool = false

    @Published var serName: String = ""
    @Published var serProd: String = ""
    @Published var serPrice: String = ""
    @Published var serDescr: String = ""

    @Published var services: [ServiceModel] = []
    @Published var selectedService: ServiceModel?

    func addService() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "ServiceModel", into: context) as! ServiceModel

        loan.serName = serName
        loan.serProd = serProd
        loan.serPrice = serPrice
        loan.serDescr = serDescr

        CoreDataStack.shared.saveContext()
    }

    func fetchServices() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ServiceModel>(entityName: "ServiceModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.services = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.services = []
        }
    }

}
