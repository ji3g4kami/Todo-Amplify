//
//  ContentView.swift
//  Todo
//
//  Created by 登秝吳 on 01/07/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var todos = Array(0..<100).map { _ in UUID().uuidString }
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(todos, id: \.self) { todo in
                       Text(todo)
                    }
                }
                VStack {
                    Spacer()
                    Button(action: {}, label: {
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
