//
//  WeatherViewModel.swift
//  LloydsTask
//
//  Created by apple on 15/11/24.
//

import Foundation

class WeatherViewModel {
    private let weatherService = WeatherService.shared
    
    var temperatureText: ((String) -> Void)?
    var isLoading: ((Bool) -> Void)?

    func fetchWeather(for city: String) {
        self.isLoading?(true)
        weatherService.fetchWeather(for: city) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading?(false)
                switch result {
                case .success(let weatherResponse):
                    self?.temperatureText?("\(weatherResponse.main.temp)°C")
                case .failure:
                    self?.temperatureText?("Error fetching weather")
                }
            }
        }
    }
}

