//
//  ContentView.swift
//  DiskUtility
//
//  Created by shahzadahmad on 02/09/2025.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var fetcher = DiskInfoFetcher()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Disk Utility")
                .font(.headline)
            DiskInfoListView(diskInfos: fetcher.diskInfos)
            DiskInfoChart(diskInfos: fetcher.diskInfos)
        }
        .padding()
        .task {
            do {
                fetcher.diskInfos = try await fetcher.getDiskInfo()
            } catch {
                fetcher.error = error
            }
        }
    }
}

#Preview {
    ContentView()
        .frame(width: 300, height: 400)
}
