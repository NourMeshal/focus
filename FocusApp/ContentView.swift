//
//  ContentView.swift
//  FocusApp
//
//  Created by Nour Altunaib on 4/30/21.
//

import SwiftUI

struct ContentView: View {
    @State var animate = false
    @State var endSplash = false
    var body: some View {
        ZStack{
            TimerView()
            ZStack{
                Color("Color")
                    
                    //Scaling View...
                    .scaleEffect(animate ? 3:1)
                    //Setting width to avoid OverSize..
                    .frame(width: UIScreen.main.bounds.width)
                
            }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .onAppear(perform: animateSplash)
            // hiding view after finished...
            .opacity(endSplash ? 0:1)
        }
        
    }
    func animateSplash(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            
            withAnimation(Animation.easeOut(duration: 0.55)){
                animate.toggle()
            }
            withAnimation(Animation.linear(duration: 0.45)){
                endSplash.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TimerView: View {
    @State var timeInSec = 0
    @State var stillSec = true
   @State var showingAlert = false
    @State var timeInMin = -1
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        NavigationView {
            ZStack{
                Color("Color")
                HStack{
                    Image("Img1")
                        .resizable()
                        .frame(width: 215, height: 360, alignment: .leading)
                        .offset(x: 100, y: -300)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                }
                VStack{
                    
                    Text("\(timeInMin):\(timeInSec)")
                        .foregroundColor(Color("Forground"))
                        .font(.custom("PTSerif-Bold.ttf", size: 80))
                        .offset(x: 1, y: -50)
                        .onReceive(timer) { _ in
                            repeat {
                                if timeInSec == 60 {
                                    self.stillSec = false
                                    self.timeInMin += 1
                                    self.timeInSec = 0
                                }
                                self.timeInSec += 1
                            }
                            while stillSec
                        }
                    
                    
                    VStack {
                        Button("Stop") {
                         self.showingAlert = true
                            self.timer.upstream.connect().cancel()
                            
                        }.foregroundColor(Color("Forground"))
                        .font(.system(size: 30))
                        .buttonStyle(OutlineButton())
                        .offset(x: 1, y: 100)
                        .sheet(isPresented: $showingAlert) {
                            VStack {
                                Text("ddd")
                            }
                        }
                    }
                    
                }
            }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            
        }
    }
    
    struct OutlineButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration
                .label
                .foregroundColor(configuration.isPressed ? Color("Forground") : Color("Forground"))
                .padding()
                .frame(width: 350, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(
                    RoundedRectangle(
                        cornerRadius: 15,
                        style: .continuous
                    ).stroke(Color("Forground"))
                )
        }
    }
    
    
}






