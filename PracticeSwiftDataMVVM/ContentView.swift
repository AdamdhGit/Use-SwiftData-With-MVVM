//
//  ContentView.swift
//  PracticeSwiftDataMVVM
//
//  Created by Adam Heidmann on 7/10/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @State var viewModel:ViewModel
    //set this just to the data type.
    
    //@Query var users:[User] = [User]()
    //@Environment(\.modelContext) var modelContext
    //both the above properties moved to ViewModel
    
    var body: some View {
        VStack {
            Button("Add Users"){
                
                    viewModel.addNames()
                
            }
            
            List(viewModel.users){i in
                Text(i.name)
            }
            
            
        }.onAppear{
            //try? viewModel.modelContext.delete(model: User.self)
            //clean slate
            //MUST REFERENCE viewModel here too now to access modelContext deletion. modelContext is now accessible via ViewModel!!!
                    }
    
    }
    
    init(modelContext: ModelContext) {
            let viewModel = ViewModel(modelContext: modelContext)
            _viewModel = State(initialValue: viewModel)
        }
    //the ViewModel can NOT access modelContext via the environment like normal. so you have to manually pass in the modelContext. we are initializing our connecting to the view model (the local viewModel property) with data type of ModelContext. that means to create a ContentView, we must now pass it that memberwise initiazer we just created.
    //also pass an initial value into the viewModel so it doesn't refresh everytime this view is opened. remember @State is a wrapper and to access the property inside a wrapper you use _ then property name, such as _viewModel.
    
}

#Preview {
    
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: false)
        let container = try ModelContainer(for: User.self, configurations: config)
        return ContentView(modelContext: container.mainContext).modelContainer(container)
        //**PASS IN container.mainContext to satisfy the preview for this manual implementation of @Query.
    } catch {
        return Text(error.localizedDescription)
    }
    
   
}
