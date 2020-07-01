//
//  NewTodoView.swift
//  Todo
//
//  Created by 登秝吳 on 01/07/2020.
//

import SwiftUI
import Amplify

struct NewTodoView: View {
    
    @State private var text = String()
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("Enter a new Todo")
                .font(.largeTitle)
            
            TextEditor(text: $text)
                .padding(.horizontal)
            
            Button(action: saveTodo, label: {
                Text("Save")
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(4)
            })
            
            Spacer()
                .frame(height: 30)
        }
    }
    
    
    private func saveTodo() {
        print(text)
        
        let todo = Todo(body: text)
        
        Amplify.DataStore.save(todo) { result in
            switch result {
            case .success:
                print("save todo")
            case .failure(let error):
                print(error)
            }
        }
        
        self.isPresented = false
    }
}

struct NewTodoView_Previews: PreviewProvider {
    static var previews: some View {
        NewTodoView(isPresented: .constant(true))
    }
}
