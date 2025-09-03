//
//  DiskInfo.swift
//  DiskUtility
//
//  Created by shahzadahmad on 02/09/2025.
//
import Foundation

struct DiskInfo {
    let fileSystemName: String
    let used: Int64
    let available: Int64
    let size: Int64
    let capacity: Int
    let mountPoint: String
    
    var isSystemVolume: Bool {
        mountPoint == "/"
    }
       
    var isDataVolume: Bool {
        mountPoint == "/System/Volumes/Data"
    }
}

extension Array where Element == DiskInfo {
    var systemVolume: DiskInfo? {
        first { $0.isSystemVolume }
    }
    
    var dataVolume: DiskInfo? {
        first { $0.isDataVolume }
    }
}

