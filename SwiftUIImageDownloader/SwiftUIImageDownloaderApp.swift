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
            TabView {
                ContentView()
                    .tabItem {
                        Image(systemName: "mappin.circle")
                        Text("Menu")
                    }
                
                MessagesView()
                    .tabItem {
                        Image(systemName: "message")
                        Text("Message")
                    }
                
                CameraView()
                    .tabItem {
                        Image(systemName: "camera")
                        Text("Camera")
                    }
                
                
                StoriesView()
                    .tabItem {
                        Image(systemName: "person.2")
                        Text("Stories")
                    }
                
                SpotlightView()
                    .tabItem {
                        Image(systemName: "arrowtriangle.right")
                        Text("Soptlight")
                    }
            }
        }
    }
}
