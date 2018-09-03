//
//  DweetAPITextCase.swift
//  DweetyTests
//
//  Created by Mohamed EL Meseery on 9/4/18.
//  Copyright © 2018 Meseery. All rights reserved.
//

import XCTest

class DweetAPITextCase: XCTestCase {
    
    func testDweetAPIWorker()  {
         let worker = DweetAPIWorker()
        let successRetrieval = expectation(description: "Dweets retrieved successfully")
        waitForExpectations(timeout: 30) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
        worker.getDweets(for: "nsemi",
                         ifSucceeded: { (dweets) in
            XCTAssert(dweets != nil, "Dweets retrieved successfully")
            successRetrieval.fulfill()
        }) { (error) in
        }
    }
    
}
