//
//  NetworkManager.swift
//  Hacker News Client (SWIFTUI)
//
//  Created by Tyler Dakin on 3/17/20.
//  Copyright © 2020 Tyler Dakin. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject { //ObservableObject protocol is allowing this class to "broadcast" one or many of its properties
    
    @Published var articles = [Article]()
    
    func fetchData(searchTerm: String?, completionHandler: @escaping (Bool) -> Void) {
        articles = []
        completionHandler(true)
        if let search: String = searchTerm, searchTerm != "" {
            if let url = URL(string: "https://newsapi.org/v2/top-headlines?sortBy=publishedAt&q=\(search)&apiKey=\(apiKey)") {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error == nil {
                        //No errors, we probably have some data!
                        let decoder = JSONDecoder()
                        if let safeData = data {
                            do {
                                let results = try decoder.decode(Results.self, from: safeData)
                                DispatchQueue.main.async {
                                    self.articles = results.articles
                                    completionHandler(false)
                                }
                            }
                            catch {
                                print("ERROR: \n\(error)")
                            }

                        }
                    }
                }
                task.resume()
            }
        }
        else if let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    //No errors, we probably have some data!
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.articles = results.articles
                                completionHandler(false)
                            }
                        }
                        catch {
                            print("ERROR: \n\(error)")
                        }

                    }
                }
            }
            task.resume()
        }
    }
}
