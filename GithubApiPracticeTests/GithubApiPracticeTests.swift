//
//  GithubApiPracticeTests.swift
//  GithubApiPracticeTests
//
//  Created by 松山響也 on 2020/07/10.
//  Copyright © 2020 Kyoya Matsuyama. All rights reserved.
//

import XCTest
@testable import GithubApiPractice

extension RepositoryModel{
    static var exampleJSON: String{
        return """
        {
        "name":"Test"
        "full_name":"Sample/Test"
        "description":"This is test JSON"
        "html_url":"http://example.com"
        }
        """
    }
}


class GithubApiPracticeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDecode(){
        func testDecode() throws {
            let encoder = JSONEncoder()
            let data = RepositoryModel.exampleJSON
            let repository = try encoder.encode(data)
            let decoder = JSONDecoder()
            let decodedStruct = try decoder.decode(RepositoryModel.self, from: repository)
            XCTAssertEqual(decodedStruct.items[0].name, "Test")
            XCTAssertEqual(decodedStruct.items[0].fullName, "Sample/Test")
            XCTAssertEqual(decodedStruct.items[0].description, "This is test JSON")
            XCTAssertEqual(decodedStruct.items[0].htmlURL, "http://example.com")
        }
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
