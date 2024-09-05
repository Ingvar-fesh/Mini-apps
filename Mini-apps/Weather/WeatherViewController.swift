import UIKit
import CoreLocation

final class WeatherViewController: UIViewController, WeatherModelDelegate {
    let locationManager = CLLocationManager()
    let weatherModel = WeatherModel()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        label.textAlignment = .center
        label.text = "--°C"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textAlignment = .center
        label.text = "Загрузка..."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        weatherModel.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(temperatureLabel)
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            temperatureLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func didUpdateWeather(_ weather: Weather) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = "\(weather.temperature)°C"
            self.descriptionLabel.text = weather.description
        }
    }
    
    func didFailWithError(_ error: any Error) {
        print("Ошибка загрузки данных о погоде: \(error.localizedDescription)")
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            weatherModel.fetchWeather(for: location.coordinate)
            locationManager.stopUpdatingLocation()
        }
    }
}

