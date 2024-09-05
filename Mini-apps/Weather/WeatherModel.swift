import UIKit
import CoreLocation

protocol WeatherModelDelegate: AnyObject {
    func didUpdateWeather(_ weather: Weather)
    func didFailWithError(_ error: Error)
}

struct Weather {
    var temperature: Double
    var description: String
}

final class WeatherModel {
    weak var delegate: WeatherModelDelegate?
    
    func fetchWeather(for coordinate: CLLocationCoordinate2D) {
        let apiKey = "58972f94d5eb70fa56d007991912345b"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=\(apiKey)&units=metric&lang=ru"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                self?.delegate?.didFailWithError(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let main = json["main"] as? [String: Any],
                   let temp = main["temp"] as? Double,
                   let weatherArray = json["weather"] as? [[String: Any]],
                   let weather = weatherArray.first,
                   let description = weather["description"] as? String {
                    
                    let weatherData = Weather(temperature: temp, description: description.capitalized)
                    self?.delegate?.didUpdateWeather(weatherData)
                }
            } catch {
                self?.delegate?.didFailWithError(error)
            }
        }
        task.resume()
    }
}
