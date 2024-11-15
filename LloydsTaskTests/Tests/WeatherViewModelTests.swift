//
//  WeatherViewModelTests.swift
//  LloydsTask
//
//  Created by apple on 15/11/24.
//

import XCTest
@testable import LloydsTask

class WeatherViewModelTests: XCTestCase {
    
    func testTemperatureFormatting() {
        let viewModel = WeatherViewModel()
        let expectation = self.expectation(description: "Temperature displayed correctly")

        viewModel.temperatureText = { text in
            XCTAssertTrue(text.contains("°C"))
            expectation.fulfill()
        }

        viewModel.fetchWeather(for: "Hyderabad")
        wait(for: [expectation], timeout: 2.0)
    }
}
