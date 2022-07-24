//
//  PlanetViewModel.swift
//  Sysco LABS
//
//  Created by AsankaTipple on 7/23/22.
//

import Foundation
import RxSwift
import RxCocoa

public enum RequestType: String {
    case GET, POST, PUT,DELETE
}

class PlanetViewModel {
    
    func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
            return Observable<T>.create { observer in
                let request = apiRequest.request(with: apiRequest.baseURL)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    do {
                        let model: Planets = try JSONDecoder().decode(Planets.self, from: data ?? Data())
                        observer.onNext( model.results as! T)
                    } catch let error {
                        observer.onError(error)
                    }
                    observer.onCompleted()
                }
                task.resume()
                
                return Disposables.create {
                    task.cancel()
                }
            }
        }
}

class APIRequest {
    let baseURL = URL(string: "https://swapi.dev/api/planets")!
    var method = RequestType.GET
    var parameters = [String: String]()
    
    func request(with baseURL: URL) -> URLRequest {
          var request = URLRequest(url: baseURL)
           request.httpMethod = method.rawValue
           request.addValue("application/json", forHTTPHeaderField: "Accept")
           return request
       }
}
