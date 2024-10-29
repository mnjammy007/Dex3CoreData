//
//  FetchImage.swift
//  Dex3CoreData
//
//  Created by Apple on 29/10/24.
//

import SwiftUI

struct FetchedImage: View {
    let url: URL?
    var body: some View {
        if let url, let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .shadow(color: .black, radius: 6)
        }
        else {
            Image(.bulbasaur)
                .resizable()
                .scaledToFit()
                .shadow(color: .black, radius: 6)
        }
    }
}

#Preview {
    FetchedImage(url: SamplePokemon.samplePokemon.sprite)
}
