//
//  KakaoAPI.swift
//  brandSearchApp (iOS)
//
//  Created by 오상구 on 2021/10/16.
//

import Foundation
import Combine
import Alamofire

enum KakaoAPI {
    static let limit = 30
    static let apiClient = APIClient()
    static let baseURL = appConfig.baseURL + "/search/image"
    
    static func fetchKakao(keyword: String, page: Int) -> AnyPublisher<SearchResponse, APIError> {
        let parameter = [
            "query": keyword,
            "page": "\(page)",
            "size": "\(limit)"
        ]
        
        let request = AF.request(
            baseURL,
            method: .get,
            parameters: parameter,
            encoder: URLEncodedFormParameterEncoder(destination: .methodDependent),
            headers: ["Authorization": "KakaoAK \(Constant.kakakAppKey)" ]
        )

        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

