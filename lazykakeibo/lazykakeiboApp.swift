//
//  lazykakeiboApp.swift
//  lazykakeibo
//
//  Created by Lucas Barbosa de Oliveira on 13/05/22.
//

import SwiftUI


@main
struct lazykakeiboApp: App {
    var body: some Scene {
        let persistentContainer = PersistentController.shared
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistentContainer.container.viewContext)
        }
    }
}
