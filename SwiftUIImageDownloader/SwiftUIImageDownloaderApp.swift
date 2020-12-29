//
//  SwiftUIImageDownloaderApp.swift
//  SwiftUIImageDownloader
//
//  Created by Sushant Ubale on 12/27/20.
//

import SwiftUI

@main
struct SwiftUIImageDownloaderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
