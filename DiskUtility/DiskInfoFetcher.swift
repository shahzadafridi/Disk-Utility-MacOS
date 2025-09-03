//
//  DiskInfoFetcher.swift
//  DiskUtility
//
//  Created by shahzadahmad on 02/09/2025.
//

import Foundation

class DiskInfoFetcher: ObservableObject {
    
    enum CommandError: Error {
        case InvalidateCommand(String)
        case FailedToExecuteCommand(String)
        case EmptyOutput(String)
    }
    
    @Published var diskInfos: [FormattedDiskInfo] = []
    @Published var error: Error?
    @Published var isLoading: Bool = false
    
    func getDiskInfo() async throws -> [FormattedDiskInfo] {
        try await Task.detached(priority: .userInitiated) {
            let output = try self.execute("df -k")
            let infos = try self.parse(output)
            let formattedDiskInfos = self.parse(infos)
            return formattedDiskInfos
        }.value
    }
    
    private func execute(_ command: String) throws -> String {
        let process = Process()
        let pipe = Pipe()
        process.launchPath = "/bin/sh"
        process.arguments = ["-c", command]
        process.standardOutput = pipe
        try process.run()
        process.waitUntilExit()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        guard let output = String(data: data, encoding: .utf8) else { throw CommandError.InvalidateCommand("Invalid command entered") }
        
        process.waitUntilExit()
        guard process.terminationStatus == 0 else { throw CommandError.FailedToExecuteCommand(output) }
        
        return output
        
    }
    
    func parse(_ output: String) throws -> [DiskInfo] {
        let lines = output.components(separatedBy: .newlines)
        guard lines.count > 1 else {
            throw CommandError.EmptyOutput("No output from command")
        }

        // Drop header line
        let dataLines = lines.dropFirst()

        return dataLines.compactMap { line -> DiskInfo? in
            let components = line.split(separator: " ", omittingEmptySubsequences: true)
            guard components.count >= 9 else { return nil }

            return DiskInfo(
                fileSystemName: String(components[0]),
                used: Int64(components[2]) ?? 0,
                available: Int64(components[3]) ?? 0,
                size: Int64(components[1]) ?? 0,
                capacity: Int(
                    String(components[4])
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                        .replacingOccurrences(of: "%", with: "")
                ) ?? 0,
                mountPoint: components[8...].joined(separator: " ")
            )
        }
    }
    
    func parse(_ infos: [DiskInfo]) -> [FormattedDiskInfo] {
        var result = [FormattedDiskInfo]()
        guard let system = infos.systemVolume, let data = infos.dataVolume else { return result }
        
        let total = system.size
        let used = system.used + data.used
        let free = data.available
        let other = max(0, total - used - free) // avoid negative due to rounding
        
        result.append(FormattedDiskInfo(title: "System", size: other, totalSize: total))
        result.append(FormattedDiskInfo(title: "Available", size: free, totalSize: total))
        result.append(FormattedDiskInfo(title: "User Data", size: used, totalSize: total))
        
        return result
    }
    
}
