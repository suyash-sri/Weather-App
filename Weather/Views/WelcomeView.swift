//
//  WelcomeView.swift
//  Weather
//
//  Created by Suyash Srivastav on 27/05/24.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View{
    @EnvironmentObject var locationManager: LocationManager
    var body: some View{
        VStack{
            VStack (spacing:20){
                Text("Welcome to weather app")
                    .bold()
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text("Please share you current location to get the weather in you area")
                    .padding()
                
            }.multilineTextAlignment(.center)
                .padding()
            LocationButton(.shareCurrentLocation){
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(/*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
            .foregroundColor(.white)
            

            
        } .frame(maxWidth:.infinity,maxHeight:.infinity)
    }
        }

//
