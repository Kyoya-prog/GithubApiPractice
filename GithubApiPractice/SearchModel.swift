//
//  SearchModel.swift
//  GithubApiPractice
//
//  Created by 松山響也 on 2020/07/10.
//  Copyright © 2020 Kyoya Matsuyama. All rights reserved.
//

import Foundation

public struct RepositoryModel:Codable{
    var items:[Repo]
    public struct Repo:Codable{
        var name:String!
        var fullName:String!
        var description:String!
        var htmlURL:String

        private enum CodingKeys:String, CodingKey{
            case fullName = "full_name"
            case name
            case description
            case htmlURL = "html_url"
        }
    }

}
protocol SearchModelInput{
    
    func searchRepository(query:String,complition:@escaping ()->Void)
    func numberRepositories()->Int
    func RepositoryForRowAt(IndexPath:Int)->RepositoryModel.Repo
    
    
}

class SearchModel:SearchModelInput{
    
    var RepositoriesArray = [RepositoryModel.Repo]()
    func searchRepository(query:String,complition: @escaping ()->Void) {
        let urlRequest = createURLRequest(query: query)
        print(urlRequest)
        let decoder = JSONDecoder()
        let task = URLSession.shared.dataTask(with: urlRequest){ (Data,URLResponse, Error) in
            do{
                self.RepositoriesArray.removeAll()
                let decodedStruct = try decoder.decode(RepositoryModel.self, from: Data!)
                for i in 0..<decodedStruct.items.count{
                    self.RepositoriesArray.append(decodedStruct.items[i])
                    print("データ取り出し中")
                }
            }catch{
            }
            print("非同期処理はここ")
            complition()
            print("ここまで")
        }
        
        task.resume()
    }
    
    func createURLRequest(query:String)->URLRequest{
        let baseURLString = "https://api.github.com/search/repositories"
        let parameter = query
        let urlString = baseURLString + "?q=\(parameter)"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
    
    func numberRepositories() ->Int{
        return RepositoriesArray.count
    }
    func RepositoryForRowAt(IndexPath indexPath:Int) -> RepositoryModel.Repo {
        return RepositoriesArray[indexPath]
    }
}