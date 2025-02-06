//
//  WorkViewModel.swift
//  TH_App30
//
//  Created by IGOR on 05/02/2025.
//

import SwiftUI
import CoreData

final class WorkViewModel: ObservableObject {
    
    @Published var skins: [String] = ["Oily", "Dry", "Combination", "Sensitive"]
    @Published var currentSkin = ""

    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isSettings: Bool = false
    @Published var isDetail: Bool = false
    
    @Published var addingIncome: Int = 0
    @AppStorage("totalIncome") var totalIncome: Int = 0

    @Published var woClient: String = ""
    @Published var woServ: String = ""
    @Published var woDate: Date = Date()
    @Published var woTime: Date = Date()
    @Published var woIncome: String = ""

    @Published var works: [WorkModel] = []
    @Published var selectedWork: WorkModel?

    func addWork() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "WorkModel", into: context) as! WorkModel

        loan.woClient = woClient
        loan.woServ = woServ
        loan.woDate = woDate
        loan.woTime = woTime
        loan.woIncome = woIncome

        CoreDataStack.shared.saveContext()
    }

    func fetchWorks() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<WorkModel>(entityName: "WorkModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.works = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.works = []
        }
    }

}
