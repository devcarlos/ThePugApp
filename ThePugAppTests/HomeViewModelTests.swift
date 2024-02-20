//
//  HomeViewModelTests.swift
//  ThePugAppTests
//
//  Created by Carlos Alcala on 19/02/2024
//

import XCTest
import ThePugApp

class HomeViewModelTests: XCTestCase {

    var viewModel : HomeViewModel!
    private var service : MockService!

    override func setUp() {
        super.setUp()
        self.service = MockService()
        self.viewModel = HomeViewModel(service: service)
    }

    override func tearDown() {
        self.viewModel = nil
        self.service = nil
        super.tearDown()
    }

    func testloadNextPageWithNoService() {

        // giving no service to a view model
        viewModel.service = nil

        viewModel.loadNextPage(handler: { result in
            switch result {
            case .success:
                XCTAssert(false, "ViewModel should not be able to load without service")
            case .failure:
                XCTAssert(false, "ViewModel should not be able to load without service")
            }
        })
    }

    func testloadDataWithPugService() {

        // setting up expectation
        let dataExpectation = expectation(description: "loadNextPage expectation")

        // inject PugService service to test view model real callback
        self.viewModel = HomeViewModel(service: PugService())

        self.viewModel.loadNextPage(handler: { result in
            switch result {
            case .success:
                XCTAssertTrue(self.viewModel.pugs.count == 20, "ViewModel data should count 20")
                dataExpectation.fulfill()
            case .failure:
                XCTAssert(false, "ViewModel should not fail on this service")
                dataExpectation.fulfill()
            }
        })

        // check for expectation
        wait(for: [dataExpectation], timeout: 60)
    }

    func testLikes() {
        self.viewModel = HomeViewModel(service: PugService())

        var pug = Pug(id: UUID(), image: "", likes: 1)
        self.viewModel.pugs = [pug]

        pug.likes += 1

        self.viewModel.updatePug(pug: pug)

        XCTAssertTrue(pug.likes == 2, "Likes count should be 2")
        XCTAssertTrue(self.viewModel.pugs.first?.likes == 2, "Likes count should be 2")
    }
}

private class MockService : ServiceProtocol {
    var requestCalled: Bool = false
    func GETRequest<T: Codable>(_ parameters: [String: String], completionBlock: @escaping (Response<T>) -> Void) {
        requestCalled = true
    }
}
