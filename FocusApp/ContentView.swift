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
            
            /*Image("bigIcon")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: animate ? .fill : .fit)
                .frame(width: animate ? nil : 200, height: animate ? nil : 200)*/
            
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
    @State var timeRemaining = 1
    @State var hours = 1
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
                
                Text("\(timeRemaining)")
                    .foregroundColor(Color("Forground"))
                    .font(.custom("PTSerif-Bold.ttf", size: 80))
                    .offset(x: 1, y: -50)
                    .onReceive(timer) { _ in
                          if timeRemaining > 0 {
                           timeRemaining += 1
                   }
                }
            
                
                Button("Stop") {
                    self.timer.upstream.connect().cancel()
                
                }.foregroundColor(Color("Forground"))
                .font(.system(size: 30))
                .buttonStyle(OutlineButton())
                .offset(x: 1, y: 100)
    
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




    

