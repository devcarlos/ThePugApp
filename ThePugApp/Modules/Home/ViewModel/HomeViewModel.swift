//
//  HomeViewModel.swift
//  ThePugApp
//
//  Created by Carlos Alcala on 19/02/2024
//  Copyright © 2024 ThePugApp. All rights reserved.
//

import Foundation

enum PugError: Error {
    case dataFailure
    case noMorePages
    case unexpected(code: Int)
}

struct Paginate {
    var limit: Int = 20
    var page: Int = 1
    var hasMorePages: Bool = true
}

class HomeViewModel: NSObject {
    var currentPugData: PugData?
    var pugs: [Pug] = []
    var paginate = Paginate()

    var service: ServiceProtocol?

    init(service: ServiceProtocol? = PugService()) {
        self.service = service
    }
}

extension HomeViewModel {
    func loadNextPage(handler: @escaping (Result<Void, PugError>) -> Void) {
        guard paginate.hasMorePages == true else {
            return
        }

        let params: [String : String] = [:]

        service?.GETRequest(params) { (response: Response<PugData>) in
            switch response {
            case .success(let data):
                self.currentPugData = data
                self.pugs.append(contentsOf: self.currentPugData?.pugs ?? [])
                handler(.success(()))

            case .failure(let error):
                print("error.code \(String(describing: error.code))")
                print("error.message \(String(describing: error.message))")
                handler(.failure(.dataFailure))
            default:
                print("default")
            }
        }
    }

    func updatePug(pug: Pug?) {
        guard let pug = pug, let index = self.pugs.firstIndex(where: { $0.id == pug.id }) else {
            return
        }
        pugs[index].likes = pug.likes

        print("pugs[index].id", pugs[index].id)
        print("pugs[index].likes", pugs[index].likes)
        print("")
    }
}
