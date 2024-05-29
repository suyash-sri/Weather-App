//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Suyash Srivastav on 28/05/24.
//

import SwiftUI
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weather: ResponseBody
    @Published var dateString: String = ""
    @Published var feelsLike: String = ""
    @Published var weatherMain: String = ""
    @Published var weatherMinTemp: String = ""
    @Published var weatherMaxTemp: String = ""
    @Published var windSpeed: String = ""
    @Published var humidity: String = ""

    init(weather: ResponseBody) {
        self.weather = weather
        getDate()
        getFeelsLike()
        getWeatherMain()
        getWeatherMinTemp()
        getWeatherMaxTemp()
        getWindSpeed()
        getHumidity()
    }

    func getDate() {
        self.dateString = Date().formatted(.dateTime.month().day().hour().minute())
    }

    func getFeelsLike() {
        self.feelsLike = String(format: "%.0f°", weather.main.feelsLike)
    }

    func getWeatherMain() {
        self.weatherMain = weather.weather.first?.main ?? ""
    }

    func getWeatherMinTemp() {
        self.weatherMinTemp = String(format: "%.0f°", weather.main.tempMin)
    }

    func getWeatherMaxTemp() {
        self.weatherMaxTemp = String(format: "%.0f°", weather.main.tempMax)
    }

    func getWindSpeed() {
        self.windSpeed = String(format: "%.1f m/s", weather.wind.speed)
    }

    func getHumidity() {
        self.humidity = String(format: "%.0f%%", weather.main.humidity)
    }
}
