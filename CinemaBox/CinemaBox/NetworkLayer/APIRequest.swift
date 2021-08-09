//
//  APIRequest.swift
//  CinemaBox
//
//  Created by Jack on 02/08/21.
//

import Foundation
import RxSwift

enum Endpoint: String {
    case topRated = "top_rated"
    case popular
}

enum APIServiceError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}

class APIRequest {
    private let apiKey = "YOUR_API_KEY"
    private let imageBaseUrl = "http://image.tmdb.org/t/p/"
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!
    
    private let urlSession = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    static let shared = APIRequest()
    private init() { }
    
    func fetchMovies(from endpoint: Endpoint, result: @escaping (Result<MovieResponse, APIServiceError>) -> Void) {
        let movieURL = baseURL
            .appendingPathComponent("movie")
            .appendingPathComponent(endpoint.rawValue)
        fetchResources(url: movieURL, completion: result)
    }
    
    private func fetchResources<T: Decodable>(url: URL, completion: @escaping (Result<T, APIServiceError>) -> Void) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: url) { (result) in
            switch result {
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let values = try self.jsonDecoder.decode(T.self, from: data)
                    completion(.success(values))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure:
                completion(.failure(.apiError))
            }
        }.resume()
    }
}

extension APIRequest {
    func getImageURL(for path: String, size: String = "500") -> URL? {
        let formattedUrl = imageBaseUrl + "w\(size)"
        let url = URL(string: formattedUrl + path)
        return url
    }
}
