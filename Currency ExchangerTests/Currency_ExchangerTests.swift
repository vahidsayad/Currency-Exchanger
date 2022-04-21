//
//  Currency_ExchangerTests.swift
//  Currency ExchangerTests
//
//  Created by Vahid Sayad on 21/4/2022 .
//

import XCTest
@testable import Currency_Exchanger

class Currency_ExchangerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsAmountValid() throws {
        let sut = HomeView.ViewModel()
        sut.amount = "aer"
        sut.exchange()
        XCTAssertEqual(sut.alertMessage, "enter_valid_amount".localized)
        
        sut.amount = "10.2"
        sut.exchange()
        XCTAssertNotEqual(sut.alertMessage, "enter_valid_amount".localized)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
