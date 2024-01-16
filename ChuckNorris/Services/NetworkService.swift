//
//  NetworkService.swift
//  ChuckNorris
//
//  Created by Дмитрий Снигирев on 14.01.2024.
//

import Foundation


final class NetworkService {
    
    typealias Categories = [String]
        
    static func requestJoke(completion: @escaping (Result<Joke,Error>) -> Void) {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else { return }
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            }
            
            if let HTTPResponse = response as? HTTPURLResponse {
                switch HTTPResponse.statusCode {
                case 200:
                    guard let data = data else {
                        return
                    }
                    do {
                        let joke = try JSONDecoder().decode(Joke.self, from: data)
                        completion(.success(joke))
                    } catch {
                        print(error.localizedDescription)
                        completion(.failure(error))
                    }
                case 404:
                    print("404")
                default:
                    break
                }
            }
        }
        dataTask.resume()
    }
    
    static func requestCategories(completion: @escaping (Result<Categories, Error>) -> Void) {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/categories") else { return }
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            }
            
            if let HTTPResponse = response as? HTTPURLResponse {
                switch HTTPResponse.statusCode {
                case 200:
                    guard let data = data else {
                        return
                    }
                    do {
                        let category = try JSONDecoder().decode(Categories.self, from: data)
                        completion(.success(category))
                    } catch {
                        print(error.localizedDescription)
                        completion(.failure(error))
                    }
                case 404:
                    print("404")
                default:
                    break
                }
            }
        }
        dataTask.resume()
    }
}
