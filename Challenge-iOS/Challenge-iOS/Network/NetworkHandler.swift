//
//  NetworkHandler.swift
//  Challenge-iOS
//
//  Created by Patricio Perez on 29/04/2024.
//

import Foundation

protocol NetworkProtocol {
    // Categories
    func getCategories(completion: @escaping (Result<[Category], Error>) -> Void)
    func getCategoryDetail(id: String, itemsOffset: Int, completion: @escaping (Result<CategoryDetailResponse, Error>) -> Void)
}

class NetworkHandler: NetworkProtocol {
    static let shared = NetworkHandler()
    
    func getCategoryDetail(id: String, itemsOffset: Int,  completion: @escaping (Result<CategoryDetailResponse, Error>) -> Void) {
        getResources(.categoryDetail(id: id, offset: itemsOffset), completionHandler: completion)
    }
    func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        getResources(.categories, completionHandler: completion)
    }
}

extension NetworkHandler {
    fileprivate func getResources<T: Decodable>(_ request: NetworkRequest, completionHandler: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: Global.baseURL + request.path) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method
        
        if let body = request.body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        if let headers = request.headers {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(error!))
                }
                return
            }
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse else { return }
            
            if httpResponse.statusCode == 200 {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .millisecondsSince1970 //.formatted(dateFormatter)
                do {
                    let models = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(.success(models))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completionHandler(.failure(error))
                    }
                }
                
            } else {
                //completionHandler(.failure(self.getErrorFromData(data, httpResponse: httpResponse)))
                completionHandler(.failure(NSError(domain: "NETWORK ERROR", code: httpResponse.statusCode, userInfo: nil)))
            }
        }
        
        task.resume()
    }
}
