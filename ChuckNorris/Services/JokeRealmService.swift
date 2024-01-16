//
//  JokeRealmService.swift
//  ChuckNorris
//
//  Created by Дмитрий Снигирев on 15.01.2024.
//

import Foundation
import RealmSwift

final class JokeRealmService {
    
    func fetchJokes() -> [Joke] {
        do {
            let realm = try Realm()
            let objects = realm.objects(Joke.self)
            
            guard let jokeRealm = Array(objects) as? [Joke] else { return [] }
            
            return jokeRealm
        } catch {
            return []
        }
    }
    
    func addJoke(joke: Joke) {
        do {
            let realm = try Realm()
            let newJoke = Joke()
            newJoke.value = joke.value
            newJoke.category.append(objectsIn: joke.category)
            newJoke.downloadDate = Date()
            do {
                try realm.write {
                    realm.add(newJoke)
                }
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
}
