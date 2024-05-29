//
//  WeatherView.swift
//  Weather
//
//  Created by Suyash Srivastav on 28/05/24.
//


import SwiftUI

struct WeatherView: View {

    var weather: ResponseBody
    @StateObject private var viewModel: WeatherViewModel

    init(weather: ResponseBody) {
        self.weather = weather
        _viewModel = StateObject(wrappedValue: WeatherViewModel(weather: weather))
    }
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold()
                        .font(.title)
                    
                    Text("Today, \(viewModel.dateString))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            Image(systemName: "cloud")
                                .font(.system(size: 40))
                            
                            Text("\(viewModel.weatherMain)")
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(viewModel.feelsLike)                            
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    Spacer()
                        .frame(height:  80)
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now")
                        .bold()
                        .padding(.bottom)
                    
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Min temp", value: viewModel.weatherMinTemp )
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Max temp", value: viewModel.weatherMaxTemp)
                    }
                    
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind speed", value: viewModel.windSpeed)
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: viewModel.humidity)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                .background(.white)

            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

struct WeatherRow: View {
    let logo: String
    let name: String
    let value: String

    var body: some View {
        HStack {
            Image(systemName: logo)
                .foregroundColor(.blue)
                .font(.system(size: 20))
    
            Text(name)
            Spacer()
            Text(value)
          
        }
        .padding(.horizontal)
    }
}
