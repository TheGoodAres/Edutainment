//
//  QuestionsView.swift
//  Edutainment
//
//  Created by Robert-Dumitru Oprea on 17/03/2023.
//

import SwiftUI

struct QuestionsView: View {
    @State private var currentRound = 0
    @State private var score = 0
    @State var firstNumber: Int
    @State var secondNumber: Int
    var imageName: String
    var maxRound: Int
    var difficulty: Int
    @State var showAlert = false
    @State var alertMessage = ""
    @State var userAnswer = 0
    @State var alertTitle = ""
    @State var isRotating = 0.0
    @FocusState var answerIsFocused

    init(imageName: String, maxRound: Int, difficulty: Int) {
        self.imageName = imageName
        self.maxRound = maxRound
        self.difficulty = difficulty
        self._firstNumber = State(initialValue: Int.random(in: 1...difficulty))
        self._secondNumber = State(initialValue: Int.random(in: 1...difficulty))
    }
    @Environment(\.dismiss) var dismiss
    var body: some View {

        ZStack {
            LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: Color(hue: 0.6041513925575349, saturation: 0.3123422186058688, brightness: 1.0, opacity: 1.0), location: 0.0008505894587591203), Gradient.Stop(color: Color(hue: 0.6736135827489647, saturation: 0.3931346111987011, brightness: 1.0, opacity: 1.0), location: 0.5044278071476862), Gradient.Stop(color: Color(hue: 0.6041513925575349, saturation: 0.3568685600556523, brightness: 1.0, opacity: 1.0), location: 1.0)]), startPoint: UnitPoint.topLeading, endPoint: UnitPoint.bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                GeometryReader { geo in
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.3)
                        .position(x: geo.size.width * 0.5, y: geo.size.width * 0.11)
                        .rotationEffect(.degrees(isRotating))


                    HStack {
                        Text("Your score is \(score)")
                            .font(.title2)
                        Spacer()
                        Text("Round: \(currentRound + 1) / \(maxRound)")
                            .font(.title2)

                    }
                        .position(x: geo.size.width * 0.45, y: geo.size.height * 0.4)
                        .padding()
                    Spacer()
                    Spacer()

                    Text("What is \(firstNumber) X \(secondNumber)?")
                        .font(.title)
                        .foregroundColor(Color(red: 233 / 255, green: 233 / 255, blue: 94 / 255))
                        .position(x: geo.size.width * 0.5, y: geo.size.height * 0.7)
                    TextField("Answer", value: $userAnswer, format: .number)
                        .keyboardType(.decimalPad)
                        .background(.yellow)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .cornerRadius(90)
                        .frame(width: 200)
                        .position(x: geo.size.width * 0.5, y: geo.size.height * 0.8)
                        .focused($answerIsFocused)
                    Spacer()
                    Button("Check answer!") {
                        checkAnswer()
                    }
                        .padding()
                        .background(Color(red: 82 / 255, green: 255 / 255, blue: 86 / 255))
                        .cornerRadius(100)
                        .frame(width: 200, height: 200)
                        .position(x: geo.size.width * 0.5, y: geo.size.height * 0.95)
                }
            }
        }
            .alert(alertTitle, isPresented: $showAlert) {
            Text("Hello")

        } message: {
            Text(alertMessage)
        }
            .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    answerIsFocused = false

                }
            }
        }
    }
    func checkAnswer() {
        if(userAnswer == firstNumber * secondNumber) {
            alertTitle = "Success"
            alertMessage = "That's right, \(firstNumber) * \(secondNumber) is \(firstNumber * secondNumber)"
            score += 1
            withAnimation(.linear(duration: 1)) {
                isRotating = 360
            }
        } else {
            alertTitle = "Incorrect"
            alertMessage = "Don't worry, you will get it right next time!\n\(firstNumber) * \(secondNumber) = \(firstNumber * secondNumber)"
            withAnimation(.linear(duration: 1)) {
                isRotating = -360
            }
        }
        showAlert = true
        currentRound += 1
        if(currentRound == maxRound) {
            showAlert = true
            alertTitle = "The end"
            alertMessage = "Your score is \(score)"
            dismiss()
        }
        firstNumber = Int.random(in: 1...difficulty)
        secondNumber = Int.random(in: 1...difficulty)
        isRotating = 0
        userAnswer = 0

    }
}

struct QuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionsView(imageName: "bear", maxRound: 5, difficulty: 12)
    }
}
