//
//  SwiftUIView.swift
//  kakeibo
//
//  Created by Lucas Barbosa de Oliveira on 11/05/22.
//
//view da tabview
import Foundation
import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView{
            TodayView().tabItem{
                Image(systemName: "clock")
                Text("Hoje")
            }
            HistoryView().tabItem{
                Image(systemName: "calendar")
                Text("Histórico")
            }
        }.accentColor(.black)
        
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView().previewLayout(.fixed(width: 375, height: 1000)).environment(\.colorScheme, .light)
    }
}


  
