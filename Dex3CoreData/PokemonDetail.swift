//
//  PokemonDetail.swift
//  Dex3CoreData
//
//  Created by Apple on 29/10/24.
//

import SwiftUI
import CoreData

struct PokemonDetail: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var pokemon: Pokemon
    @State var isShowingShiny = false
    
    var body: some View {
        ScrollView {
            ZStack {
                Image(.normalgrasselectricpoisonfairy)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .black, radius: 6)
                AsyncImage(url: isShowingShiny ? pokemon.shiny : pokemon.sprite) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 50)
                        .shadow(color: .black, radius: 6)
                } placeholder: {
                    ProgressView()
                }
            }
            HStack {
                ForEach(pokemon.types!, id: \.self) { pokeType in
                    Text(pokeType.capitalized)
                        .font(.title2)
                        .shadow(color: .white, radius: 1)
                        .padding([.top, .bottom], 7)
                        .padding([.leading, .trailing])
                        .background(Color(pokeType.capitalized))
                        .cornerRadius(50)
                }
                Spacer()
                Button {
                    withAnimation {
                        pokemon.favorite.toggle()
                        do {
                            try viewContext.save()
                        } catch {
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                    }
                } label: {
                    Image(systemName: pokemon.favorite ? "star.fill" : "star" )
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                }

            }
            .padding()
            
            Text("Stats")
                .font(.title)
                .padding(.bottom, -5)
            Stats()
                .environmentObject(pokemon)
        }
        .navigationTitle(pokemon.name!.capitalized)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isShowingShiny.toggle()
                } label: {
                    Image(systemName: isShowingShiny ? "wand.and.stars" : "wand.and.stars.inverse")
                        .foregroundColor(isShowingShiny ? .yellow : .accentColor)
                }
            }
        }
    }
}

#Preview {
    PokemonDetail()
        .environmentObject(SamplePokemon.samplePokemon)
}
