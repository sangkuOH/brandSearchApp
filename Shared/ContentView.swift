//
//  ContentView.swift
//  Shared
//
//  Created by 오상구 on 2021/10/15.
//

import SwiftUI
import AlamofireNetworkActivityLogger

struct ContentView: View {
    init() {
        NetworkActivityLogger.shared.startLogging()
    }
    
    var body: some View {
        SearchView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
