//
//  ContentView.swift
//  TimesTables
//
//  Created by Samet Karakurt on 1.02.2022.
//

import SwiftUI

struct Question {
    var text: String
    var answer: Int
}

struct AnswerButton: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(width: 150, height: 75)
            .background(.white)
            .foregroundColor(.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 20))

    }
}

extension View {
    func buttonStyle() -> some View {
        modifier(AnswerButton())
    }
}

struct ButtonImage: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(0.3)
            .frame(width: 10, height: 10)
    }
}

extension View {
    func buttonImageStyle() -> some View {
        modifier(ButtonImage())
    }
}

struct MainButton: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(width: 180, height: 30, alignment: .center)
            .font(.title3.weight(.heavy))
            .foregroundColor(.white)
            .font(.subheadline.weight(.heavy))
            .padding()
    }
}

extension View {
    func mainButtonStyle() -> some View {
        modifier(MainButton())
    }
}

struct Header: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .font(.subheadline.weight(.heavy))
            .padding()
            .background(Color.init(red: (254/255), green: (205/255), blue: (2/255)))
            .clipShape(Capsule())
            .padding(.bottom, 10)
            .padding(.top, 50)
            .shadow(radius: 5)
    }
}

extension View {
    func headerStyle() -> some View {
        modifier(Header())
    }
}





struct ContentView: View {
    @State private var practiseValue = 0
    @State private var questionAmount = 5
    @State private var isGameStart = false
    @State private var gameOver = false
    @State private var questions = [Question]()
    @State private var currentQuestion = 0
    @State private var answerOfQuestions = [Int]()
    @State private var selectedNumber = Int.random(in: 1...10)
    @State private var score = 0
    @State private var isTrue = false
    @State private var isTapped = false
    @State private var animationAmount = 0.0
    
    
    let questionNumber = [5,10,20]
    @State private var imagesName = ["parrot", "duck", "dog", "horse", "rabbit", "whale", "rhino", "elephant", "zebra", "chicken", "cow", "panda", "hippo", "gorilla", "owl", "penguin", "sloth", "frog", "narwhal", "buffalo", "monkey", "giraffe", "pig", "snake", "bear", "chick", "walrus", "goat", "crocodile"]
    
    var body: some View {
        if(isGameStart){
            ZStack{
                Color.init(red: (60/255), green: (36/255), blue: (92/255))
                    .ignoresSafeArea()
                
                VStack{
                    
                    Spacer()
                    Spacer()
                    HStack{
                        Text(questions[currentQuestion].text)
                            .font(.title.weight(.heavy))
                            .foregroundColor(.black)
                        
                        Image("questionMark")
                            .renderingMode(.original)
                            .scaleEffect(0.08)
                            .frame(width: 40, height: 0, alignment: .center)
                        
                    }
                    .frame(maxWidth: 340, maxHeight: 100)
                    .padding(.vertical, 20)
                    .background(isTapped ? (isTrue ? .green : .red) : .white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .rotation3DEffect(.degrees(animationAmount), axis: ( x: 0, y: 1, z: 0))
                    .animation(.default, value: isTrue)
                
                    VStack(spacing:15){
                    
                        HStack(spacing:30){
                            Button{
                                isTrue(answer: answerOfQuestions[0])
                            }label: {
                                HStack(spacing:45){
                                    
                                    Image(imagesName[0])
                                        .renderingMode(.original)
                                        .buttonImageStyle()
   
                                    Text("\(answerOfQuestions[0])")
                                        .foregroundColor(.black)
                                        .font(.title3.weight(.heavy))
           
                                }
 
                            }
                            .buttonStyle()

                            Button{
                                isTrue(answer: answerOfQuestions[1])
                            }label: {
                                HStack(spacing:45){
                                    
                                    Image(imagesName[1])
                                        .renderingMode(.original)
                                        .buttonImageStyle()

                                    Text("\(answerOfQuestions[1])")
                                        .foregroundColor(.black)
                                        .font(.title3.weight(.heavy))
           
                                }
 
                            }
                            .buttonStyle()
                        }
                        HStack(spacing:30){
                            Button{
                                isTrue(answer: answerOfQuestions[2])
                            }
                        label: {
                            HStack(spacing:45){
                                
                                Image(imagesName[2])
                                    .renderingMode(.original)
                                    .buttonImageStyle()

                                Text("\(answerOfQuestions[2])")
                                    .foregroundColor(.black)
                                    .font(.title3.weight(.heavy))
       
                            }

                        }
                        .buttonStyle()
                            Button{
                                isTrue(answer: answerOfQuestions[3])
                            }
                        label: {
                            HStack(spacing:45){
                                
                                Image(imagesName[3])
                                    .renderingMode(.original)
                                    .buttonImageStyle()

                                Text("\(answerOfQuestions[3])")
                                    .foregroundColor(.black)
                                    .font(.title3.weight(.heavy))
       
                            }

                        }
                        .buttonStyle()
                        }
                    }.padding(30)
                    Spacer()
                   Text("Score : \(score)")
                        .foregroundColor(.white)
                        .font(.title.bold())
                    Spacer()
                    Section{
                        Button("End Game"){
                            restart()
                        }
                        .mainButtonStyle()
                        .background(.red)
                        .clipShape(Capsule())
                        
                    }
                    Spacer()
                }
                .alert("Game Over", isPresented: $gameOver) {
                    Button("Restart"){

                        restart()
                    }
                }
                message: {
                   Text("Your score is \(score)")
               }
            }
            
        }else{
            
            ZStack{
                Color.init(red: (60/255), green: (36/255), blue: (92/255))
                    .ignoresSafeArea()
                
                VStack(spacing :15){
                    Spacer()
                    Text("Times Tables")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    
        

                    Section{
                        Picker("", selection: $practiseValue) {
                            ForEach(1..<11) {
                                Text("\($0)")

                                    
                            }
                        }
                        .pickerStyle(.segmented)
                        .colorMultiply(.secondary)
                        .background(.white)
                        .padding()
                        
                        
                    }
                    header:{
                        Text("Which number do you want to practise?")
                            .foregroundStyle(.white)
                            .font(.subheadline.weight(.heavy))
                            .padding()
                            .background(Color.init(red: (254/255), green: (205/255), blue: (2/255)))
                            .clipShape(Capsule())
                            .padding(.bottom, 10)
                            .padding(.top, 50)
                            .shadow(radius: 5)
                    }
                    Section{
                        Picker("", selection: $questionAmount ) {
                            ForEach(questionNumber,id:\.self) {
                                Text("\($0)")
                            }
                        }
                        
                        .colorMultiply(.secondary)
                        .background(.white)
                        .pickerStyle(.segmented)
                        .padding()
                         
                    }header:{
                        Text("How many question do you want?")
                            .foregroundStyle(.white)
                            .font(.subheadline.weight(.heavy))
                            .padding()
                            .background(Color.init(red: (254/255), green: (205/255), blue: (2/255)))
                            .clipShape(Capsule())
              
                            .padding(.bottom, 10)
                            .padding(.top, 50)
                            .shadow(radius: 5)
                        
                    }
                    
                    Section{
                        Button("Learn"){
                            gameStart()
                        }
                        .mainButtonStyle()
                        .background(Color.init(red: (254/255), green: (205/255), blue: (2/255)))
                        .clipShape(Capsule())
                        .padding(.bottom, 10)
                        .padding(.top, 50)

                    }
                    Spacer()
                    Spacer()

                }
            }
        }
    }
    
    func isTrue(answer : Int){
        
        isTapped = true
        if(questions[currentQuestion].answer == answer){
            score += 1
            isTrue = true
            
        }else{
            score -= 1
            isTrue = false
        }
        
        questionAmount = questionAmount - 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1){
            if(questionAmount != 0){
                 changeQuestion()
            }else{
                gameOver = true
            }
        }
        withAnimation{
            animationAmount += 360
        }

    }
    func gameStart(){
        imagesName.shuffle()
        createQuestion()
        createAnswer()
        isGameStart.toggle()
    }
    func changeQuestion(){
        imagesName.shuffle()
        isTapped = false
        currentQuestion += 1
        answerOfQuestions = []
        createAnswer()
    }
    
    func createQuestion(){
        for number in 1...10{
            let newQuestion = Question(text: "\(practiseValue+1) x \(number) = ", answer: ((practiseValue+1)*number))
            questions.append(newQuestion)
        }
        self.questions.shuffle()
    }
    
    func createAnswer(){
        for number in currentQuestion...currentQuestion+3{
            answerOfQuestions.append(questions[number].answer)
        }
        answerOfQuestions.shuffle()
    }
    
    func restart(){
        isTrue = false
        isTapped = false
        currentQuestion = 0
        isGameStart.toggle()
        questionAmount = 5
        questions = []
        answerOfQuestions = []
        score = 0
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
