//
//  ContentView.swift
//  Edutainment
//
//  Created by Robert-Dumitru Oprea on 17/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var difficulty = 2
    @State private var numberOfQuestions = 5
    let numberOfQuestionsPossible = [5, 10, 20]
    let imageNames = ["bear", "buffalo", "chick"]
    let imageName: String
    init() {
        imageName = imageNames[Int.random(in: 0..<imageNames.count)]
    }
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.6041513925575349, saturation: 0.3123422186058688, brightness: 1.0, opacity: 1.0), location: 0.0008505894587591203), Gradient.Stop(color: Color(hue: 0.6736135827489647, saturation: 0.6607922013983669, brightness: 1.0, opacity: 1.0), location: 0.5044278071476862), Gradient.Stop(color: Color(hue: 0.6041513925575349, saturation: 0.3568685600556523, brightness: 1.0, opacity: 1.0), location: 1.0)]), startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Text("Let's learn!")
                        .font(.title2)
                        Image(imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    
                    Spacer()
                    HStack {
                        Spacer()
                        Text("Difficulty:")
                        Spacer()
                        Picker("Difficulty:", selection: $difficulty) {
                            ForEach(2..<21, id: \.self) { number in
                                Text("\(number)") }
                        }
                        .accentColor(.white)
                        
                    }
                        .bold()
                    Spacer()
                    VStack {
                        Text("Please choose the number of questions you would like to answer")
                            .fontWeight(.bold)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                        HStack {
                            Spacer()
                            ForEach(numberOfQuestionsPossible, id: \.self) { number in
                                Button("\(number)") {
                                    numberOfQuestions = number
                                }
                                    .frame(width: 100, height: 100)
                                    .background(.blue)
                                    .foregroundColor(.primary)
                                    .fontWeight(.bold)
                                    .cornerRadius(100)
                                Spacer()
                            }
                        }
                    }

                    NavigationLink ("Let's start!") {
                        QuestionsView(imageName: imageName, maxRound: numberOfQuestions, difficulty: difficulty)
                    }
                        .disabled(difficulty < 2)
                        .frame(width: 100, height: 100)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(100)
                        .padding()
                }

                .toolbar {
                            ToolbarItem(placement: .principal) {
                                VStack {
                                    Text("Edutainment").font(.title)
                                }
                            }
                        }
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
