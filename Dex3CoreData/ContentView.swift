//
//  ContentView.swift
//  Dex3CoreData
//
//  Created by Apple on 28/10/24.
//

import CoreData
import SwiftUI

struct ContentView: View {

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)
        ],
        animation: .default
    ) private var pokedex: FetchedResults<Pokemon>

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)
        ],
        predicate: NSPredicate(format: "favorite = %d", true),
        animation: .default
    ) private var favorite: FetchedResults<Pokemon>

    @State var isFilteredByFavorite = false
    @StateObject private var pokemonVM = PokemonViewModel(
        controller: FetchController()
    )

    var body: some View {
        switch pokemonVM.status {
        case .success:
            NavigationStack {
                List(isFilteredByFavorite ? favorite : pokedex) { pokemon in
                    NavigationLink(value: pokemon) {
                        AsyncImage(url: pokemon.sprite) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        Text(pokemon.name!.capitalized)
                        if pokemon.favorite {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                }
                .navigationTitle("Pokedex")
                .navigationDestination(
                    for: Pokemon.self,
                    destination: { pokemon in
                        PokemonDetail()
                            .environmentObject(pokemon)
                    }
                )
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation {
                                isFilteredByFavorite.toggle()
                            }
                        } label: {
                            Label(
                                "Filter By Favorites",
                                systemImage: isFilteredByFavorite
                                    ? "star.fill" : "star"
                            )
                        }
                        .tint(.yellow)
                    }
                }
            }
        default:
            ProgressView()
        }
    }
}

#Preview {
    ContentView().environment(
        \.managedObjectContext,
        PersistenceController.preview.container.viewContext
    )
}
