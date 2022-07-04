//
//  TimerView.swift
//  Timer
//
//  Created by Максим Французов on 12.09.2021.
//

import SwiftUI

struct TimerView: View {
    @Binding var actionOfTimerIsStart: Bool
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    @Binding var selectedSecond: Int
    var totalTime: Int
    var body: some View {
        VStack {
            TimerCircleView(actionOfTimerIsStart: self.$actionOfTimerIsStart, selectedHour: self.$selectedHour, selectedMinute: self.$selectedMinute, selectedSecond: self.$selectedSecond, totalTime: self.totalTime)
                .offset(y: 100)
            Spacer()
            ButtonsPauseAndCancel(selectedHour: .constant(0), selectedMinute: .constant(0), selectedSecond: .constant(0), actionOfTimerIsStart: self.$actionOfTimerIsStart)
        }
    }
}

struct TimerCircleView : View {
    
    //@State var start = false
    @State var to : CGFloat = 1
//    @State var timeRemaining = 0
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Binding var actionOfTimerIsStart: Bool
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    @Binding var selectedSecond: Int
    
    var totalTime: Int
    
    var body: some View{
        ZStack {
            VStack {
                ZStack {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                    
                    Circle()
                        .trim(from: 0, to: self.to)
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                        .rotationEffect(.init(degrees: -90))
                    
                    
                    VStack{
                        textToDoubleZero()
                            .fontWeight(.bold)
                    }
                }
                .onReceive(time) { _ in
                    if actionOfTimerIsStart == true {
                        minesTimerRemaining()
                        withAnimation(.default) {
                            let timeRemaining = selectedHour * 60 * 60 + selectedMinute * 60 + selectedSecond
                            self.to = CGFloat(timeRemaining) / CGFloat(self.totalTime)

                        }
                    }
                }
            }
        }
    }
    
    func minesTimerRemaining() {
        selectedSecond -= 1
        if selectedSecond < 0 {
            selectedMinute -= 1
            selectedSecond = 59
            if selectedMinute < 0 {
                selectedHour -= 1
                selectedMinute = 59
                if selectedHour < 0 {
                    selectedHour = 0
                    selectedMinute = 0
                    selectedSecond = 0
                    self.Notify()
                    actionOfTimerIsStart = false
                    
                }
            }
        }
    }
    
    func Notify() {
        let content = UNMutableNotificationContent()
        content.title = "Message"
        content.body = "Timer is completed successgully in background!!!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let req = UNNotificationRequest(identifier: "MSG", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(req, withCompletionHandler: nil)
        
        
    }
    
    func textToDoubleZero() -> Text {
        if ((lenghtOfNumbers(number: selectedHour) != 2) && (lenghtOfNumbers(number: selectedMinute) != 2) && (lenghtOfNumbers(number: selectedSecond) != 2)) {
            return Text("0\(selectedHour):0\(selectedMinute):0\(selectedSecond)").font(.system(size: 40))
        } else if ((lenghtOfNumbers(number: selectedHour) != 2) && (lenghtOfNumbers(number: selectedMinute) != 2)) {
            return Text("0\(selectedHour):0\(selectedMinute):\(selectedSecond)").font(.system(size: 40))
        } else if ((lenghtOfNumbers(number: selectedHour) != 2) && (lenghtOfNumbers(number: selectedSecond) != 2)) {
            return Text("0\(selectedHour):\(selectedMinute):0\(selectedSecond)").font(.system(size: 40))
        } else if ((lenghtOfNumbers(number: selectedMinute) != 2) && (lenghtOfNumbers(number: selectedSecond) != 2)) {
            return Text("\(selectedHour):0\(selectedMinute):0\(selectedSecond)").font(.system(size: 40))
        } else if (lenghtOfNumbers(number: selectedHour) != 2) {
            return Text("0\(selectedHour):\(selectedMinute):\(selectedSecond)").font(.system(size: 40))
        } else if (lenghtOfNumbers(number: selectedMinute) != 2) {
            return Text("\(selectedHour):0\(selectedMinute):\(selectedSecond)").font(.system(size: 40))
        } else if (lenghtOfNumbers(number: selectedSecond) != 2) {
            return Text("\(selectedHour):\(selectedMinute):0\(selectedSecond)").font(.system(size: 40))
        }
        return Text("You choose \(selectedHour):\(selectedMinute):\(selectedSecond)").font(.system(size: 40))
    }
    
    func lenghtOfNumbers(number: Int) -> Int {
        var result = 0
        var deliteLastNumber = number
        while (deliteLastNumber > 0) {
            result += 1
            deliteLastNumber = deliteLastNumber / 10
        }
        return result
    }
}

struct ButtonsPauseAndCancel: View {
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    @Binding var selectedSecond: Int
    //@Binding var start: Bool
    @Binding var actionOfTimerIsStart: Bool
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .strokeBorder(Color(#colorLiteral(red: 0.7626844669, green: 0.7626844669, blue: 0.7626844669, alpha: 1)).opacity(0.8) ,lineWidth: 3)
                    .frame(width: 100, height: 100, alignment: .center)
                Button(action: {
                    actionOfTimerIsStart.toggle()
                    selectedHour = 0
                    selectedMinute = 0
                    selectedSecond = 0
                }) {
                    Text("Cancel")
                }
                .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(#colorLiteral(red: 0.7626844669, green: 0.7626844669, blue: 0.7626844669, alpha: 1)).opacity(0.8))
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            }
            Spacer()
            ZStack {
                Circle()
                    .strokeBorder(Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)).opacity(0.8) ,lineWidth: 3)
                    .frame(width: 100, height: 100, alignment: .center)
                Button(action: {
                    self.actionOfTimerIsStart.toggle()
                }) {
                    Text("Pause") .font(.title)
                }
                .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)).opacity(0.8))
                .foregroundColor(Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)))
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            }
        }.padding()
    }
}



struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(actionOfTimerIsStart: .constant(false), selectedHour: .constant(0), selectedMinute: .constant(0), selectedSecond: .constant(0), totalTime: 0)
    }
}
