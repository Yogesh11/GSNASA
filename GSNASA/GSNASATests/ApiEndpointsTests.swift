//
//  ApiEndpointsTests.swift
//  GSNASATests
//
//  Created by Yogesh2 Gupta on 23/07/22.
//

import XCTest
@testable import GSNASA

class ApiEndpointsTests: XCTestCase {

    func testApodURL() throws {
        
        let apodURL = ApiEndpoints(date: "test").apodURL
        let testURL = "https://\(Constants.getApodBaseURL())/planetary/apod?api_key=\(Constants.getAPIKey())&date=test"
        XCTAssertEqual(apodURL, testURL)
    }
}
