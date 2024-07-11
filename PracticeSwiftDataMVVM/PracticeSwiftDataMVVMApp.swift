//
//  PracticeSwiftDataMVVMApp.swift
//  PracticeSwiftDataMVVM
//
//  Created by Adam Heidmann on 7/10/24.
//

import SwiftData
import SwiftUI

@main
struct PracticeSwiftDataMVVMApp: App {
    
    let container: ModelContainer
    //create a container of data type ModelContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView(modelContext: container.mainContext)
            //access the mainContext through ModelContainer (where it truly exists). The only alternative to accessing it easily through the @Environment with @Query.
            
        }//.modelContainer(for: User.self) would be used for normal @Query
        .modelContainer(container)
    }
    
    init() {
           do {
               container = try ModelContainer(for: User.self)
               //set the container to the associated @Model
           } catch {
               fatalError("Failed to create ModelContainer for Movie.")
           }
       }
    
    
}

//***MANUALLY SETTING UP SWITCH DATA @QUERY SO THAT YOU CAN USE MVVM WITH SWIFTDATA (AS OF 07/10/2024 - COULD CHANGE IN FUTURE AND BE MADE EASIER)
//we access the mainContext via ModelContainer where is actaully exists
//we specify which @Model the mainContext will work with, becoming the modelContext
//we pass that into the first view that exists, ContentView().
//we then pass the modelContext off to the viewModel from ContentView via an init(){} inside ContentView.
//we also set the initial value of the modelContext in that init(){} so we retain our data, the whole point of SwiftData.
//^which is possible because our ViewModel has an init(){} setup to receive a modelContext.
//in ViewModel we init(){} by fetching data from the modelContext and any insert/delete to modelContext we will also fetch data. that way data is up to data and RETAINED at all times. even on initialization of course.
//lastly, pass in container.mainContext to satisfy the preview for this manual implementation of @Query in the ContentView preview.

