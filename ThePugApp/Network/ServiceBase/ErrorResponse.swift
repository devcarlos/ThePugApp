//
//  ErrorResponse.swift
//  ThePugApp
//
//  Created by Carlos Alcala on 19/02/2024
//  Copyright © 2024 ThePugApp. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    var code: Int?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case code
        case message
    }

    init(error: Error) {
        if (error as NSError).code > 0 {
            self.code = (error as NSError).code
        } else {
            self.code = 10001
        }
        self.message = error.localizedDescription
    }

    init(code: Int?, message: String?) {
        self.code = code
        self.message = message
    }
}
