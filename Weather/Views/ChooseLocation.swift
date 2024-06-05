
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
    @StateObject var viewModel = ChooseLocationViewModel()
    @State var selectedCoordinat:CLLocationCoordinate2D?
    var body: some View{
        NavigationStack{
            VStack{
                Map(coordinateRegion: $viewModel.region ,showsUserLocation: true)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        selectedCoordinat = viewModel.region.center
                        print(selectedCoordinat)
                        Task {
                            await viewModel.navigateToNext()
                        }
                    }
                ButtonsView(viewModel:viewModel )
                
            }.navigationDestination(isPresented: $viewModel.navigateToWeatherView) {
                
                if let weather = viewModel.weather {
                    WeatherView(weather: weather)
                } else {
                    Text("Weather data is not available")
                }
            }
            
        }
        
    }
    
    struct ButtonsView : View{
        @State var viewModel :ChooseLocationViewModel
        var body :some View{
            HStack{
                Button(
                    action:{
                        withAnimation{
                            viewModel.zoomIn()
                            
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
                            viewModel.zoomOut()
                            
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
    }
}



