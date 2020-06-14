//
//  PexelsAPISearchTests.swift
//  PexelsAPISearchTests
//
//  Created by Anthony Torres on 6/12/20.
//  Copyright © 2020 John Torres. All rights reserved.
//

import XCTest
@testable import PexelsAPISearch

class PexelsAPISearchTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testGettingImages() throws {
        // Both id and url are nil. This function wont work without one or the other.
        APIService.shared.getImage(with: nil, url: nil) { (image) in
            XCTAssertNil(image)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
