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
        let thing = "nsemi"
        let successRetrieval = expectation(description: "Dweets retrieved successfully")
        worker.getDweets(for:thing ,
                         ifSucceeded: { (dweets) in
            successRetrieval.fulfill()
        }) { (error) in
            XCTFail("Dweets failed to be retrieved with error \(error)")
        }
        waitForExpectations(timeout: 30) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
