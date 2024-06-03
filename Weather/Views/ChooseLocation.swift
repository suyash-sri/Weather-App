
////
////  ChooseLocation.swift
////  Weather
////
////  Created by Suyash Srivastav on 29/05/24.
////
//

import SwiftUI
import MapKit

struct ChooseLocation: View{
    
    @StateObject var locationManager = LocationManager()
    @State var region = MKCoordinateRegion(
        center:CLLocationCoordinate2D(latitude: 37.7, longitude:-122.4194 ) ,
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    @State var selectedCoordinat:CLLocationCoordinate2D?
    @State var navigateToWeatherView:Bool = false
    
    func navigateToNext() async {
        do {

            weather = try await weatherManager.getCurrentWeather(latitude: selectedCoordinat?.latitude ??  37.7, longitude: selectedCoordinat?.longitude ?? -122.4194 )
           navigateToWeatherView = true
            
        } catch {
            print("Error fetching weather: \(error)")
        }
    }
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

    
    var body: some View{
        NavigationStack{
        VStack{
            Map(coordinateRegion: $region ,showsUserLocation: true)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .onTapGesture {
                    selectedCoordinat = region.center
                    print(selectedCoordinat)
                    
                        Task {
                                          await navigateToNext()
                                      }
                                  }
            HStack{
                Button(
                    action:{
                        withAnimation{
                            zoomIn()
                            
                        }
                    }){
                    Image(systemName: "plus.magnifyingglass")
                        .padding()
                        .background(Color.white)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .shadow(radius: 4)
                    
                }
                Button(
                    action : {
                        withAnimation{
                            zoomOut()
                     
                        }
                    }){
                    Image(systemName: "minus.magnifyingglass")
                        .padding()
                        .background(Color.white)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .shadow(radius: 4)
                    
                }
                
            }
  
        }
        }      .navigationDestination(isPresented: $navigateToWeatherView) {
            if let weather = weather {
                WeatherView(weather: weather)
            } else {
                Text("Weather data is not available")
            }
        }
    
  }

}




