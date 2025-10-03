//
//  ContentView.swift
//  GuessingTheFlag
//
//  Created by Faki Doosuur Doris on 10.08.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var Score = 0
    @State private var Questions = true
    @State private var questionCounter = 1
    @State private var showingResults = false
    @State private var animationAmount = 0.0
    @State private var flagChosen = ""
    
    
    @State private var countries = ["Nigeria" ,"Ireland" , "Estonia","Russia", "US", "UK",].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
    
    
    var body: some View {
        
        
        
        
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red:0.1,green:0.2,blue:0.45), location: 0.3),
                .init(color: Color(red:0.76,green:0.15,blue:0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 15){
                    VStack{
                        
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundColor(.white)
                        
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.secondary)
                        
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number: number)
                                withAnimation{
                                    animationAmount += 360
                                    
                                }
                                
                                
                                
                                
                                
                            }label: {
                                Image(countries[number]) //getting the flags from the projects.
                                    .renderingMode(.original)
                                // .clipShape(Capsule())
                                //.shadow(radius: 5?)
                                
                            }
                            
                            
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    
                    
                    
                    
                    Spacer()
                    Spacer()
                    
                    Text("Score : \(Score)")
                    
                        .foregroundColor(.white)
                        .font(.title.bold())
                    Spacer()
                    
                }
                
                .padding()
                
                
            }
            
            
            .alert(scoreTitle, isPresented: $showingScore){
                Button("Continue" , action: askQuestion)
            }message:{
                Text("Your score is \(Score) ")
                
            }
        }
                    
                
                
                
                .alert("Game over!", isPresented: $showingResults) {
                    Button("Start Again", action: newGame)
                } message: {
                    Text("Your final score was \(Score).")
                }
        
            }
        
    
            
            
            
            
            
    func flagTapped(number: Int) {
        
        let needsThe = ["UK", "US"]
        let theirAnswer = countries[number]
        
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            Score += 2
            askQuestion()
               
                
        }else{
            if needsThe.contains(theirAnswer) {
                scoreTitle = "Wrong! That's the flag of the \(theirAnswer)."
            } else {
                scoreTitle = "Wrong! That's the flag of \(theirAnswer)."
                
                
                if Score > 0{
                    Score -= 1
                }
            }
            
            
            
            if questionCounter == 8{
                showingResults = true
                
            }else{
                showingScore = true
            }
            
            
        }
    }
                
                
                
                
                   func askQuestion(){
                    countries.shuffle()
                    correctAnswer = Int.random(in: 0...2)
                }
                
                
                
                
                func newGame() {
                    questionCounter = 0
                    Score = 0
                    askQuestion()
                }
                
                
                
            }
        
    
    
    
    



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
