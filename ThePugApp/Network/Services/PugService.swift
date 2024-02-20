//
//  PugService.swift
//  ThePugApp
//
//  Created by Carlos Alcala on 19/02/2024
//  Copyright © 2024 ThePugApp. All rights reserved.
//

import Foundation

protocol ServiceProtocol: AnyObject {
    func GETRequest<T: Codable>(_ parameters: [String: String], completionBlock: @escaping(Response<T>)->Void)
}

final class PugService {
    private var serviceBase: ServiceBaseProtocol
    private var endPointName = "PugsEndpoint"

    init(serviceBase: ServiceBaseProtocol = ServiceBase.sharedInstance()) {
        self.serviceBase = serviceBase
    }
}

private extension PugService {
    func getEndPoint() -> String {
        guard let path = Bundle.main.url(forResource: "EndPoints", withExtension: "plist"),
              let endPoints = NSDictionary(contentsOf: path) else {
            return ""
        }
        return endPoints.value(forKey: endPointName) as? String ?? ""
    }
}

extension PugService: ServiceProtocol {
    func GETRequest<T: Codable>(_ parameters: [String: String], completionBlock: @escaping (Response<T>) -> Void) {
        let endPoint = getEndPoint()
        self.serviceBase.GETRequest(endPoint, parameters: parameters, completionBlock: completionBlock)
    }
}
