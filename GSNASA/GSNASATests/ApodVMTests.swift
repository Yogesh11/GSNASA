//
//  Test_DemoTests.swift
//  GSNASATests
//
//  Created by Yogesh2 Gupta on 23/07/22.
//

import XCTest
@testable import GSNASA

class Test_DemoTests: XCTestCase {
    
    var sut: ApodHomeViewModel!

    override func setUpWithError() throws {
        sut = ApodHomeViewModel()
    }
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testUpdateQueryDate() {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.ApodDateFormat
        let dateString = dateFormatter.string(from: date)
        
        sut.updateQueryDate(queryDate: Date())
        
        XCTAssertEqual(dateString as NSString, sut.queryDate )
        
        let testDate = dateFormatter.date(from: "2022-07-22")
        sut.updateQueryDate(queryDate: testDate!)
        
        XCTAssertEqual("2022-07-22" as NSString, sut.queryDate )
        
    }
    
    func testUpdateData() {
        
        var response = ApodResponse(date: "testDate", title: "testTitle", explanation: "testExp", url: "testUrl", media_type: "image")
        
        sut.updateResponse(apodApiResponse: response)
        
        XCTAssertEqual("testDate", sut.date )
        XCTAssertEqual("testTitle", sut.title )
        XCTAssertEqual("testExp", sut.explanation )
        XCTAssertEqual("testUrl", sut.url )
        XCTAssertEqual(Constants.MediaType.image, sut.media_type )
        
        response = ApodResponse(date: "testDate", title: "testTitle", explanation: "testExp", url: "testUrl", media_type: "video")
        
        sut.updateResponse(apodApiResponse: response)
        
        XCTAssertEqual(Constants.MediaType.video, sut.media_type )
    }
}








