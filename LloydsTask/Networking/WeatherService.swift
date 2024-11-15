//
//  WeatherService.swift
//  LloydsTask
//
//  Created by apple on 15/11/24.
//

import Foundation

struct WeatherResponse: Codable {
    let main: MainWeather
}

struct MainWeather: Codable {
    let temp: Double
}

class WeatherService {
    static let shared = WeatherService()
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "OpenWeatherMapAPIKey") as? String
    
    private init() {}

    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        guard let apiKey = apiKey else { return }
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse))
            } catch let decodeError {
                completion(.failure(decodeError))
            }
        }.resume()
    }
}
