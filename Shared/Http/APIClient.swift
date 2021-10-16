//
//  APIClient.swift
//  brandSearchApp (iOS)
//
//  Created by 오상구 on 2021/10/16.
//

import Foundation
import Combine
import Alamofire

enum APIError: Error {
    case http(ErrorData)
    case unknown
}

struct ErrorData: Codable {
    let message: String
    let errorType: String
}

struct APIClient {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
        
    func run<T: Decodable>(_ request: DataRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, APIError> {
        
        return request
            .validate()
            .publishData(emptyResponseCodes: [200, 204, 205])
            .tryMap { result -> Response<T> in
                if let error = result.error {
                    if let errorData = result.data {
                        let value = try decoder.decode(ErrorData.self, from: errorData)
                        throw APIError.http(value)
                    }
                    else {
                        throw error
                    }
                }
                if let  data = result.data {
                    let value = try decoder.decode(T.self, from: data)
                    return Response(value: value, response: result.response!)
                } else {
                    return Response(value: Empty.emptyValue() as! T, response: result.response!)
                }
            }
            .mapError({ (error) -> APIError in
                if let apiError = error as? APIError {
                    return apiError
                } else {
                    return .unknown
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
