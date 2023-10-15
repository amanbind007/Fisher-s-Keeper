//
//  FishCardView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 06/10/23.
//

import CachedAsyncImage
import SwiftUI

struct FishCardView: View {
    let fish: Fish
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                CachedAsyncImage(url: URL(string: fish.imageURL ?? "")) { image in
                    image
                        .resizable()
                        .frame(width: .infinity, height: 200)
                        .cornerRadius(10)
                        
                } placeholder: {
                    Image("fishPlaceholder", bundle: Bundle(path: "Assets"))
                        .resizable()
                        .frame(width: .infinity, height: 200)
                        .cornerRadius(10)
                }
                   
                HStack {
                    Text(fish.scientificName ?? "")
                        .font(Font.custom("PTSerif-BoldItalic", size: 20))
                    Spacer()
                }
                .padding(.horizontal, 7)
                HStack {
                    Text(fish.commonEnglishName ?? "")
                        .font(Font.custom("PTSerif-Regular", size: 18))
                    
                    Spacer()
                    Text(fish.familyName ?? "")
                        .font(Font.custom("PTSerif-Regular", size: 15))
                }
                .padding(.horizontal, 7)
            }
            .padding(5)
            .background(.pink)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        
        .padding(.top, 8)
    }
}

#Preview {
    FishCardView(fish: FishPreviewProvider.fish)
}
