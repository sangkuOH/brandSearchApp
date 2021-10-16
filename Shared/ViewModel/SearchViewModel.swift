//
//  SearchViewModel.swift
//  brandSearchApp (iOS)
//
//  Created by 오상구 on 2021/10/15.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var inputText = ""
    @Published var data: SearchResponse?
    @Published var page = 1
    @Published var isLoading = false
    
    @Published var isError = false {
        didSet {
            if !isError {
                errorMessage = ""
            }
        }
    }
    @Published var errorMessage = "" {
        didSet {
            if errorMessage != "" {
                isError = true
            }
        }
    }
    
    lazy var debouncedText: AnyPublisher<String, Never> = {
        debounceTextMaker(for: self.$inputText)
    }()
    
    private var subscriptions = Set<AnyCancellable>()
    private let logger = AppLogger.shared
    
    deinit {
        subscriptions.forEach { subscription in
            subscription.cancel()
        }
    }
    
    func fetchData() {
        self.isLoading = true
        
        self.logger.debug("Kakao API Network Start")
        
        KakaoAPI.fetchKakao(keyword: self.inputText, page: self.page)
            .sink { completion in
                switch completion {
                case .finished:
                    self.logger.debug("KakaoAPI networking finished")
                case .failure(let error):
                    guard let reason = error.asAFError?.failureReason else {
                        self.logger.error(error.localizedDescription)
                        self.errorMessage = error.localizedDescription
                        return
                    }
                    self.logger.error(reason)
                    self.errorMessage = reason
                }
            } receiveValue: {
                if self.data == nil {
                    self.data = $0
                } else {
                    self.data?.meta = $0.meta
                    self.data?.documents.append(contentsOf: $0.documents)
                }
                self.page += 1
                self.isLoading = false
            }
            .store(in: &subscriptions)
    }
    
    func debounceTextMaker (for publisher: Published<String>.Publisher) -> AnyPublisher<String, Never> {
        let result = publisher
            .debounce(for: 1, scheduler: RunLoop.main)
            .map { $0 }
        return result.dropFirst(1).eraseToAnyPublisher()
    }
}
