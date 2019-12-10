//
//  ContentView.swift
//  iExpense
//
//  Created by Sam on 2019-12-08.
//  Copyright © 2019 Sailfish Studios. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("$\(item.amount, specifier: "%.2f")")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading:
                Button(action: {
                    self.showingAddExpense = true
                }) {
                    Image(systemName: "plus")
                },
                                trailing: EditButton()
            )
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
