//
//  ExchangeService.swift
//  Currency Exchanger
//
//  Created by Vahid Sayad on 17/4/2022 .
//

import Foundation
import Moya

enum ExchangeService {
    case exchange(amount: String, from: Currency, to: Currency)
}

extension ExchangeService: TargetType {
    var baseURL: URL {
        URL(string: "http://api.evp.lt")!
    }
    
    var path: String {
        switch self {
        case .exchange(let amount, let from, let to):
            let postfix = "\(amount)-\(from.rawValue)/\(to.rawValue)"
            return "/currency/commercial/exchange/\(postfix)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .exchange: return .get
        }
    }
    
    var task: Task {
        switch self {
        case .exchange: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
}


extension ExchangeService {
    static func exchange(amount: String, from: Currency, to: Currency, _ completion: @escaping (_ balance: BalanceResponse?, _ error: String?)->Void) {
        let provider = MoyaProvider<ExchangeService>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
        provider.request(.exchange(amount: amount, from: from, to: to)) { result in
            switch result {
            case .failure(let error):
                completion(nil, error.localizedDescription)
            case .success(let response):
                do {
                    guard let balance = try? response.map(BalanceResponse.self) else {
                        let error = try response.map(APIError.self)
                        completion(nil, error.description)
                        return
                    }
                    completion(balance, nil)
                } catch let error {
                    completion(nil, error.localizedDescription)
                }
            }
        }
    }
}

struct APIError: Decodable {
    var error: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case error
        case description = "error_description"
    }
}
