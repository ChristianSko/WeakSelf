//
//  ContentView.swift
//  WeakSelf
//
//  Created by Christian Skorobogatow on 14/7/22.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("count") var count: Int?
    
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate", destination: WeakSelfSecondView())
                .navigationTitle("Screen 1")
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(.green)
                .cornerRadius(10)
            , alignment: .topTrailing)
    }
}


struct WeakSelfSecondView: View {
    
    @StateObject var vm = WeakSelfSecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
                .foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
    
    
}

class WeakSelfSecondScreenViewModel: ObservableObject {
    @Published var data: String? = nil
    
    init() {
        print("INITIALIZE NOW")
        let currentCount =  UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("DEINITILIAZE NOW")
        let currentCount =  UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "NEW DATA!"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
