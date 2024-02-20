//
//  ServiceBaseProtocol.swift
//  ThePugApp
//
//  Created by Carlos Alcala on 19/02/2024
//  Copyright © 2024 ThePugApp. All rights reserved.
//

import Foundation

enum RequestType: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
}

enum Response<T> {
    case success(response: T)
    case failure(error: ErrorResponse)
    case jsonSerialization
}

protocol ServiceBaseProtocol: AnyObject {
    func setToken(token: String?)
    func removeToken(token: String?)
    func GETRequest<T: Codable>(_ endPoint: String, parameters: [String: String], completionBlock: @escaping(Response<T>)->())
    func POSTRequest<T: Codable>(_ endPoint: String, parameters: [String: String], completionBlock: @escaping(Response<T>)->())
}
