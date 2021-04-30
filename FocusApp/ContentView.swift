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
    @State var task: String = ""
    @State var tasks: [String]
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        NavigationView{
            ZStack{
                Color("Color")
                HStack{
                    Image("Img1")
                        .resizable()
                        .frame(width: 215, height: 360, alignment: .leading)
                        .offset(x: 100, y: -300)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                }
               
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
                VStack{
                    NavigationLink(destination: ListView()){
                        Text("Tesk")
                            .foregroundColor(Color("Forground"))
                            .font(.custom("PTSerif-Bold.ttf", size: 30))
                            .padding()
                           
                          
                             
                         
                    }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .offset(x: -148, y: -255)
                    VStack {
                        HStack{
                            Text("\(task)")
                                .foregroundColor(Color("Forground"))
                                .font(.system(size: 30))
                          
                            
                        }.offset(x: 100, y: 330)
                       
                        Button("Stop") {
                         self.showingAlert = true
                        self.timer.upstream.connect().cancel()
                            
                        }.foregroundColor(Color("Forground"))
                        .font(.system(size: 30))
                        .buttonStyle(OutlineButton())
                        .offset(x: 1, y: 100)
                        .sheet(isPresented: $showingAlert) {
                            ZStack{
                                Color("Color")
                            VStack {
                                Text("Your Done!")
                                    .offset(x: 1, y: -100)
                                    .font(.system(size: 30))
                                    .foregroundColor(Color("Forground"))
                                    .padding()
                                    .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(
                                        RoundedRectangle(
                                            cornerRadius: 15,
                                            style: .continuous
                                        ) .stroke(Color("Forground"))
                                    )
                                
                                TextField("Enter Your Task here", text: $task)
                                    .padding()
                                    .background(Color("Forground"))
                                    .border(Color("Forground"), width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                                    .accentColor(Color("Color"))
                                    .cornerRadius(15)
                                    .frame(width: 250, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .offset(x: 1, y: -200)
                                
                            
                                Button("Done"){
                                    self.showingAlert = false
                                    
                                
                                }
                                .foregroundColor(Color("Forground"))
                                .padding()
                                .frame(width: 100, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 15,
                                        style: .continuous
                                    ).stroke(Color("Forground"))
                                     
                                     
                                )
                                .offset(x: 1, y: -180)
                               }
                            }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        }
                       
                    }
                    
                }
            }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
           
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .accentColor(Color("Forground"))
        
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

struct ListView: View{
    var body: some View{
        ZStack{
            Color("Color")
            List{
                
            }
            
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}






