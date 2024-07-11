//
//  ContentView-ViewModel.swift
//  PracticeSwiftDataMVVM
//
//  Created by Adam Heidmann on 7/10/24.
//

import Foundation
import SwiftData


extension ContentView {
    
    
    @Observable class ViewModel {
        
        var hardcodedData:[User] = [User(name: "Bob"), User(name: "Jack"), User(name: "Jeff")]
        
        var modelContext: ModelContext
        var users = [User]()
        
        //@Querty fetches, it automatically updates after inserts and deletes, but we lose access to @Query if we move this all to the ViewModel. so now we have to manually set up data to be fetched everytime a change happens. if something is added, refetch. if something is deleted, refetch. @Query needs SwiftUI and this doesn't exist in view model. @Enviroment also needs SwiftUI which doesn't exist outside SwiftUI so we have to manually set up environment here too.
        
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            fetchData()
        }
        //allow ViewModel to access modelContext maually since we can't access via @Enviroment
        
        
        func addNames() {
            for i in hardcodedData {
                let user = i
                modelContext.insert(user)
            }
            fetchData()
            //if using a for loop, fetch OUTSIDE of the loop or will cause issues. fetch is done once everyting is inserted. your not fetching as each one is inserted, doing too much.
            
        }
        //example to setup a function for each insert where we manually call the fetch since we have to manually do it instead of using the magic of @Query.
        
        
        func fetchData() {
                   do {
                       let descriptor = FetchDescriptor<User>(sortBy: [SortDescriptor(\.name)])
                       //manual implementation, this says : Fetch from @Model data type of User and sort by name alphabetically. basically just says Fetch data type of User.
                       users = try modelContext.fetch(descriptor)
                       //assign what is fetched to exist in users. the array we created.
                   } catch {
                       print("Fetch failed")
                   }
               }
        //manually doing what @Query doesn. the fetch of our SwiftData.
        
        //**so modelContext actually fetches behind the scenes via @Query but we have to manually implement it since we can't access query. the modelContext that exists is established via our init(){}. 
        
        
        
    }
    
    
    
}
