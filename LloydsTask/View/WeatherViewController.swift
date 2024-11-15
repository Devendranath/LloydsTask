//
//  ViewController.swift
//  LloydsTask
//
//  Created by apple on 14/11/24.
//

import UIKit

class WeatherViewController: UIViewController {
    private let viewModel = WeatherViewModel()
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
//    private let fetchButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Get Weather", for: .normal)
//        button.backgroundColor = .systemBlue
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 8
//        return button
//    }()
    
//    private let activityIndicator: UIActivityIndicatorView = {
//        let indicator = UIActivityIndicatorView(style: .large)
//        indicator.hidesWhenStopped = true
//        return indicator
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.temperatureText = { [weak self] text in
            self?.temperatureLabel.text = text
        }
        viewModel.isLoading = { [weak self] loading in
            if loading {
                self?.activityIndicator.startAnimating()
            } else {
                self?.activityIndicator.stopAnimating()
            }
        }
    }
        
    @IBAction private func fetchWeather() {
        guard let city = cityTextField.text, !city.isEmpty else {
            temperatureLabel.text = "Please enter a city"
            return
        }
        viewModel.fetchWeather(for: city)
    }
}

