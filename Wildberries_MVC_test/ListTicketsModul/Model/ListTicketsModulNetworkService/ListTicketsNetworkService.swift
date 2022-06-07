//
//  ListTicketsNetworkService.swift
//  Wildberries_MVC_test
//
//  Created by Misha on 05.06.2022.
//

import Foundation

class ListTicketsNetworkService {
    
    func getTickets(completion: @escaping (APIResponse) -> Void?) {
        
        let urlString = "https://travel.wildberries.ru/statistics/v1/cheap"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let jsonResults = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(jsonResults)
            }
            catch {
                print{error}
            }
        }
        task.resume()
    }
}


