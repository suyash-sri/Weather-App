//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Suyash Srivastav on 28/05/24.
//
//
//import Foundation
//import CoreLocation
//
//class WeatherViewModel: ObservableObject {
//    @Published var weather: ResponseBody?
//    @Published var isLoading = false
//    
//    private let weatherManager = WeatherManager()
//    
//    func fetchWeather(for coordinate: CLLocationCoordinate2D) {
//        isLoading = true
//        weatherManager.getCurrentWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { result in
//            DispatchQueue.main.async {
//                self.isLoading = false
//                switch result {
//                case .success(let weather):
//                    self.weather = weather
//                case .failure(let error):
//                    print("Failed to fetch weather: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
//}
//


