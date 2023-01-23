//
//  ANFExploreCardAPITests.swift
//  ANF Code TestTests
//
//  Created by Elle Kadfur on 1/22/23.
//

import XCTest

//MARK: API Tests
class ANFExploreCardAPITests: XCTestCase {
    
    let ExploreCardAPIURL = "https://www.abercrombie.com/anf/nativeapp/qa/codetest/codeTest_exploreData.json"
    
    ///testAPIReturnsSuccess
    func testAPIReturnsSuccess() {
        let expectation = self.expectation(description: "API returns success")
        var statusCode: Int?
        var responseError: Error?
        let url = URL(string: ExploreCardAPIURL)!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            expectation.fulfill()
        }
        task.resume()
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    ///testAPIStatusCode
    func testAPIStatusCode() {
        let url = URL(string: ExploreCardAPIURL)!
        let expectation = XCTestExpectation(description: "API returns 200 status code")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                XCTAssertEqual(httpResponse.statusCode, 200)
                expectation.fulfill()
            }
        }.resume()
        wait(for: [expectation], timeout: 5.0)
    }
    
    ///testValid APIJSONData
    func testAPIJSONData() {
        let url = URL(string: ExploreCardAPIURL)!
        let expectation = XCTestExpectation(description: "API returns valid JSON data")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                XCTFail("Error occured while fetching data from API : \(error)")
            }
            if let data = data {
                do {
                    _ = try JSONSerialization.jsonObject(with: data)
                    expectation.fulfill()
                } catch {
                    XCTFail("API does not return valid JSON data")
                }
            }
        }.resume()
        wait(for: [expectation], timeout: 6.0)
    }
}

