//
//  DiskInfoListView.swift
//  DiskUtility
//
//  Created by shahzadahmad on 02/09/2025.
//

import SwiftUI

struct DiskInfoListView: View {
    
    var diskInfos: [FormattedDiskInfo]
    
    var body: some View {
        GroupBox {
            ForEach(diskInfos) { info in
                DiskInfoRow(info: info)
            }
            .listRowSeparator(.hidden)
        } label: {
            Text("Disk Space Overview")
        }
    }
}

#Preview {
    DiskInfoListView(diskInfos: FormattedDiskInfo.examples)
        .frame(width: 300, height: 300)
}
