//
//  NetworkService.swift
//  20211023-YanelsyRivera-NYCSchools
//
//  Created by yanelsy rivera on 10/23/21.
//

import Foundation

typealias ResultCallback<T> = (Result<T, ResultServerError>) -> Void

enum ResultServerError: LocalizedError {
    case decoding
    case server(code: Int, message: String)
}

extension ResultServerError {
    public var errorDescription: String {
        switch self {
        case .decoding:
            return "Ups! Something went wrong"
        case .server(code: let errorCode, message: let errorMessage):
            return errorMessage.isEmpty ? "Ups! Unexpected error has occurred. Code:  \(errorCode)" : errorMessage
        }
    }
}


public class APIRequest {
    //MARK:
    func get<T: Decodable>(
        url: String,
        completion: @escaping ResultCallback<T>
    ) {
        
        guard let url = URL(string: url) else {
            completion(.failure(ResultServerError.decoding))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let objectDecoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(objectDecoded))
                } catch {
                    completion(.failure(.server(code: 0, message: error.localizedDescription)))
                }
            } else if let error = error {
                completion(.failure(.server(code: 0, message: error.localizedDescription)))
            }
        }
        task.resume()
    }
    
}
