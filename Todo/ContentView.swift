//
//  ContentView.swift
//  Todo
//
//  Created by 登秝吳 on 01/07/2020.
//

import SwiftUI
import Amplify
import Combine

struct ContentView: View {
    
    @State private var todos = [Todo]()
    
    @State private var showNewTodo = false
    
    @State private var observationToken: AnyCancellable?
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(todos) { todo in
                        Text(todo.body)
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
        .onAppear {
            getTodos()
            observeTodos()
        }
    }
    
    private func getTodos() {
        Amplify.DataStore.query(Todo.self) { result in
            switch result {
            case .success(let todos):
                print(todos)
                self.todos = todos
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func observeTodos() {
        observationToken = Amplify.DataStore.publisher(for: Todo.self).sink { completion in
            if case .failure(let error) = completion {
                print(error)
            }
        } receiveValue: { changes in
            
            guard let todo = try? changes.decodeModel(as: Todo.self) else { return }
            
            switch changes.mutationType {
            case "create":
                self.todos.append(todo)
            case "delete":
                if let index = self.todos.firstIndex(of: todo) {
                    self.todos.remove(at: index)
                }
            default:
                break
            }
        }

    }
    
    private func deleteTodo(at indexSet: IndexSet) {
        print("Delete item at \(indexSet)")
        
        var updatedTodos = todos
        updatedTodos.remove(atOffsets: indexSet)
        
        guard let todo = Set(updatedTodos).symmetricDifference(todos).first else {
            return
        }
        
        Amplify.DataStore.delete(todo) { result in
            switch result {
            case .success:
                print("Deleted todo")
            case .failure(let error):
                print("Could not delete todo - \(error)")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
