//
//  Persistence.swift
//  Dex3CoreData
//
//  Created by Apple on 28/10/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let samplePokemon = Pokemon(context: viewContext)
        
        samplePokemon.id = 1
        samplePokemon.name = "bulbasur"
        samplePokemon.types = ["grass", "poison"]
        samplePokemon.hp = 45
        samplePokemon.attack = 49
        samplePokemon.defence = 49
        samplePokemon.specialAttack = 65
        samplePokemon.specialDefence = 65
        samplePokemon.speed = 45
        samplePokemon.sprite = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        samplePokemon.shiny = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png")
        samplePokemon.favorite = false
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Dex3CoreData")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        else{
            container.persistentStoreDescriptions.first!.url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.mnjammy.tech.Dex3CoreDataGroup")?.appending(path: "Dex3CoreData.sqlite")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
