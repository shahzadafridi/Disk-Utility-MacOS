//
//  FormattedDiskInfo.swift
//  DiskUtility
//
//  Created by shahzadahmad on 02/09/2025.
//

import Foundation

struct FormattedDiskInfo: Identifiable {
    
    public let id = UUID()
    public let title: String
    public let size: Int64
    public let totalSize: Int64
    
    var formattedSize: String {
        ByteCountFormatter.string(fromByteCount: size * 1024, countStyle: .file)
    }
    
    var formattedTotalSize: String {
        ByteCountFormatter.string(fromByteCount: totalSize * 1024, countStyle: .file)
    }
    
    var percentage: Double {
        Double(size) / Double(totalSize) 
    }
    
    static var examples: [FormattedDiskInfo] {
        [
            FormattedDiskInfo(
                title: "System",
                size: 90 * 1024 * 1024,
                totalSize: 910 * 1024 * 1024
            ),
            FormattedDiskInfo(
                title: "Available",
                size: 200 * 1024 * 1024,
                totalSize: 910 * 1024 * 1024
            ),
            FormattedDiskInfo(
                title: "Used",
                size: 300 * 1024 * 1024,
                totalSize: 910 * 1024 * 1024
            )
        ]
    }
}

