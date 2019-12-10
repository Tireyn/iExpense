//
//  AddView.swift
//  iExpense
//
//  Created by Sam on 2019-12-08.
//  Copyright © 2019 Sailfish Studios. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing:
                Button("Save") {
                    if let actualAmount = Double(self.amount) {
                        let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                        self.expenses.items.append(item)
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.error(title: "Invalid Value", message: "Please enter a dollar value.")
                    }
                }
            )
        }
        .alert(isPresented: $showingError) {
            Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func error(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
