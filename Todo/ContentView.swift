//
//  ContentView.swift
//  Todo
//
//  Created by 登秝吳 on 01/07/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var todos = Array(0..<100).map { _ in UUID().uuidString }
    
    @State private var showNewTodo = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(todos, id: \.self) { todo in
                       Text(todo)
                    }
                    .onDelete(perform: deleteTodo)
                }
                VStack {
                    Spacer()
                    Button(action: { showNewTodo.toggle() }, label: {
                        Image(systemName: "plus")
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.green)
                            .clipShape(Circle())
                    })
                    Spacer()
                        .frame(height: 30)
                }
            }
            .navigationTitle("Todo")
            .sheet(isPresented: $showNewTodo) {
                NewTodoView(isPresented: self.$showNewTodo)
            }
        }
    }
    
    private func deleteTodo(at indexSet: IndexSet) {
        print("Delete item at \(indexSet)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
