//
//  Pug.swift
//  ThePugApp
//
//  Created by Carlos Alcala on 19/02/2024
//  Copyright © 2024 ThePugApp. All rights reserved.
//

import Foundation

struct Pug {
    var id: UUID = UUID()
    var image: String?
    var likes: Int = 0
}

extension Pug {
    var imageURL: URL? {
        return URL(string: self.image ?? "")
    }
}
