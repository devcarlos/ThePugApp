//
//  PugData.swift
//  ThePugApp
//
//  Created by Carlos Alcala on 19/02/2024
//  Copyright © 2024 ThePugApp. All rights reserved.
//

import UIKit

struct PugData: Codable {
    var message: [String]
    var status: String

    enum CodingKeys: String, CodingKey {
        case message
        case status
    }

    var pugs: [Pug] {
        return message.map { Pug(image: $0) }
    }
}
