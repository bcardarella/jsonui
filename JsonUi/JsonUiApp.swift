//
//  JsonUiApp.swift
//  JsonUi
//
//  Created by Daniel Rees on 2/26/21.
//

import SwiftUI

@main
struct JsonUiApp: App {
    let loader: Loader
    
    init () {
        self.loader = Loader()
    }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
