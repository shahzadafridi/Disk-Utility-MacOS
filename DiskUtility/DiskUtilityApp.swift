//
//  DiskUtilityApp.swift
//  DiskUtility
//
//  Created by shahzadahmad on 02/09/2025.
//

import SwiftUI

@main
struct DiskUtilityApp: App {
    var body: some Scene {
        MenuBarExtra {
            ContentView()
                .frame(width: 300)
        } label: {
            Label("Disk Utility", systemImage: "externaldrive.connected.to.line.below.fill")
        }
        .menuBarExtraStyle(.window)
    }
}
