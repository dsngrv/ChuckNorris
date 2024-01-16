//
//  JokeRealmModel.swift
//  ChuckNorris
//
//  Created by Дмитрий Снигирев on 15.01.2024.
//

import Foundation
import RealmSwift

final class Joke: Object, Codable {
    @Persisted var value: String
    @Persisted var downloadDate = Date()
    @Persisted var category = List<String>()
    
    enum CodingKeys: String, CodingKey {
        case category = "categories"
        case value
     }
}
