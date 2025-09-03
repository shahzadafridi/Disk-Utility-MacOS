//
//  DiskInfoRow.swift
//  DiskUtility
//
//  Created by shahzadahmad on 02/09/2025.
//

//
//  DiskInfoView.swift
//  DiskUtility
//
//  Created by shahzadahmad on 02/09/2025.
//
import SwiftUI

struct DiskInfoRow: View {
    
    let info: FormattedDiskInfo
    
    var progressColor: Color {
        switch info.title {
        case "System":
            return .blue
        case "Available":
            return .green
        default:
            return .orange
        }
    }
    
    var body: some View {
        VStack{
            HStack {
                Text(info.title)
                Spacer()
                Text(info.formattedSize)
            }
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                
                Rectangle()
                    .fill(progressColor)
                    .frame(width: geometry.size.width * info.percentage)
            }
            .frame(height: 6)
            .clipShape(Capsule())
        }
    }
}

#Preview {
    DiskInfoRow(info: .examples[0])
        .padding()
        .frame(width: 300)
}
