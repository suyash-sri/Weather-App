//
//  ChooseLocationViewModel.swift
//  Weather
//
//  Created by Suyash Srivastav on 05/06/24.
//
import SwiftUI
import MapKit
import Foundation

class ChooseLocationViewModel:ObservableObject{
    @Published var region = MKCoordinateRegion(
        center:CLLocationCoordinate2D(latitude: 37.7, longitude:-122.4194 ) ,
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    var weatherManager = WeatherManager()
    @Published var weather: ResponseBody?
    @State var selectedCoordinat:CLLocationCoordinate2D?
    @Published var navigateToWeatherView:Bool = false
    
    
    func zoomIn() {
        var span = region.span
        span.latitudeDelta = max(span.latitudeDelta / 2, 0.01)
        span.longitudeDelta = max(span.longitudeDelta / 2, 0.01)
        region.span = span
    }
    
    func zoomOut() {
        var span = region.span
        span.latitudeDelta = min(span.latitudeDelta * 2, 180.0)
        span.longitudeDelta = min(span.longitudeDelta * 2, 180.0)
        region.span = span
    }
    
    func navigateToNext() async {
        do {
            weather = try await weatherManager.getCurrentWeather(latitude: selectedCoordinat?.latitude ??  37.7, longitude: selectedCoordinat?.longitude ?? -122.4194 )
            navigateToWeatherView = true
        } catch {
            print("Error fetching weather: \(error)")
        }
    }
    
}
