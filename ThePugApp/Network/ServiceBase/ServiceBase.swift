//
//  ServiceBase.swift
//  ThePugApp
//
//  Created by Carlos Alcala on 19/02/2024
//  Copyright © 2024 ThePugApp. All rights reserved.
//

import Alamofire
import Foundation
import os.log

final class ServiceBase {
    private var token: String?
    private static var sharedServiceBase: ServiceBaseProtocol = {
        ServiceBase()
    }()

    class func sharedInstance() -> ServiceBaseProtocol {
        return self.sharedServiceBase
    }

    private var baseURL: String {
        Constants.BASE_URL
    }

    private var imageHOST: String {
        Constants.IMAGE_URL
    }
}

extension ServiceBase: ServiceBaseProtocol {
    func setToken(token: String?) {
        self.token = token
    }

    func removeToken(token: String?) {
        self.token = nil
    }

    func GETRequest<T: Codable>(_ endPoint: String,
                                parameters: [String: String],
                                completionBlock: @escaping (Response<T>) -> ()) {

        let requestUrl = self.baseURL + endPoint
        AF.request(requestUrl,
                   method: HTTPMethod.get,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: self.headers()).response { response in

            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode,
                      let data = response.data else {
                    os_log("Failed getting response data", log: OSLog.default, type: .error)
                    let error = ErrorResponse(code: 1000, message: "Failed getting response data")
                    completionBlock(.failure(error: error))
                    return
                }
                switch statusCode {
                case 200 ..< 300:
                    do {
                        let decoder = JSONDecoder()
                        let serviceResponse = try decoder.decode(T.self, from: data)
                        completionBlock(.success(response: serviceResponse))
                    } catch {
                        os_log("Failed parsing response data", log: OSLog.default, type: .error)
                        completionBlock(.jsonSerialization)
                    }
                case 401:
                    let code = response.error?.responseCode
                    let message = response.error?.errorDescription
                    let errorResponse = ErrorResponse(code: code, message: message)
                    completionBlock(.failure(error: errorResponse))
                default:
                    let code = response.error?.responseCode
                    let message = response.error?.errorDescription
                    let errorResponse = ErrorResponse(code: code, message: message)
                    completionBlock(.failure(error: errorResponse))
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                os_log("Failed getting response data", log: OSLog.default, type: .error)
                let error = ErrorResponse(code: error.responseCode, message: error.localizedDescription)
                completionBlock(.failure(error: error))
            }
        }
    }

    func POSTRequest<T: Codable>(_ endPoint: String, parameters: [String: String], completionBlock: @escaping(Response<T>)->()) {
        let requestUrl = self.baseURL + endPoint

        AF.request(requestUrl,
                   method: HTTPMethod.post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: self.headers()).response { response in

            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode,
                      let data = response.data else {
                    os_log("Failed getting response data", log: OSLog.default, type: .error)
                    let error = ErrorResponse(code: 1000, message: "Failed getting response data")
                    completionBlock(.failure(error: error))
                    return
                }
                switch statusCode {
                case 200 ..< 300:
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        decoder.dateDecodingStrategy = .iso8601
                        let serviceResponse = try decoder.decode(T.self, from: data)
                        completionBlock(.success(response: serviceResponse))
                    } catch {
                        os_log("Failed parsing response data", log: OSLog.default, type: .error)
                        completionBlock(.jsonSerialization)
                    }
                case 401:
                    let code = response.error?.responseCode
                    let message = response.error?.errorDescription
                    let errorResponse = ErrorResponse(code: code, message: message)
                    completionBlock(.failure(error: errorResponse))
                default:
                    let code = response.error?.responseCode
                    let message = response.error?.errorDescription
                    let errorResponse = ErrorResponse(code: code, message: message)
                    completionBlock(.failure(error: errorResponse))
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                os_log("Failed getting response data", log: OSLog.default, type: .error)
                let error = ErrorResponse(code: error.responseCode, message: error.localizedDescription)
                completionBlock(.failure(error: error))
            }
        }
    }
}

private extension ServiceBase {
    private func headers() -> HTTPHeaders {
        var header: HTTPHeaders = ["Content-Type": "application/json;charset=utf-8"]

        if let appToken = self.token {
            header["Authorization"] = appToken
        }

        return header
    }
}
