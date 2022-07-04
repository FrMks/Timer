//
//  ContentView.swift
//  Timer
//
//  Created by Максим Французов on 08.09.2021.
//

import SwiftUI

struct ContentView: View {
    @State var selectedHour = 0
    @State var selectedMinute = 0
    @State var selectedSecond = 0
    @State var actionOfTimerIsStart: Bool
    @State var totalTime = 0
    var body: some View {
        ZStack {
            if !actionOfTimerIsStart {
                Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    ClockView(selectedHour: self.$selectedHour, selectedMinute: self.$selectedMinute, selectedSecond: self.$selectedSecond)
                    Spacer()
                    ButtonsStartAndCancel(selectedHour: self.$selectedHour, selectedMinute: self.$selectedMinute, selectedSecond: self.$selectedSecond, actionOfTimerIsStart: self.$actionOfTimerIsStart, totalTime: self.$totalTime)
                    textToDoubleZero()
                }
            } else {
                TimerView(actionOfTimerIsStart: self.$actionOfTimerIsStart, selectedHour: self.$selectedHour, selectedMinute: self.$selectedMinute, selectedSecond: self.$selectedSecond, totalTime: self.totalTime)
            }
            
        }
    }
    func textToDoubleZero() -> Text {
        if ((lenghtOfNumbers(number: selectedHour) != 2) && (lenghtOfNumbers(number: selectedMinute) != 2) && (lenghtOfNumbers(number: selectedSecond) != 2)) {
            return Text("You choose 0\(selectedHour):0\(selectedMinute):0\(selectedSecond)").font(.title)
        } else if ((lenghtOfNumbers(number: selectedHour) != 2) && (lenghtOfNumbers(number: selectedMinute) != 2)) {
            return Text("You choose 0\(selectedHour):0\(selectedMinute):\(selectedSecond)").font(.title)
        } else if ((lenghtOfNumbers(number: selectedHour) != 2) && (lenghtOfNumbers(number: selectedSecond) != 2)) {
            return Text("You choose 0\(selectedHour):\(selectedMinute):0\(selectedSecond)").font(.title)
        } else if ((lenghtOfNumbers(number: selectedMinute) != 2) && (lenghtOfNumbers(number: selectedSecond) != 2)) {
            return Text("You choose \(selectedHour):0\(selectedMinute):0\(selectedSecond)").font(.title)
        } else if (lenghtOfNumbers(number: selectedHour) != 2) {
            return Text("You choose 0\(selectedHour):\(selectedMinute):\(selectedSecond)").font(.title)
        } else if (lenghtOfNumbers(number: selectedMinute) != 2) {
            return Text("You choose \(selectedHour):0\(selectedMinute):\(selectedSecond)").font(.title)
        } else if (lenghtOfNumbers(number: selectedSecond) != 2) {
            return Text("You choose \(selectedHour):\(selectedMinute):0\(selectedSecond)").font(.title)
        }
        return Text("You choose \(selectedHour):\(selectedMinute):\(selectedSecond)").font(.title)
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

struct ClockView: View {
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    @Binding var selectedSecond: Int
    var hourNumber: Array<String> = ClockView.generateHour()
    var minuteAndSecondNumber: Array<String> = ClockView.generateMinutesAndSecond()
    let pickerWidth = CGFloat(20)
    var body: some View {
        HStack() {
            Picker(selection: $selectedHour, label: Text("Choose hour").foregroundColor(.white)) {
                ForEach (0..<hourNumber.count) { index in
                    Text(self.hourNumber[index])
                }
            }.frame(maxWidth: 135)
                .lineLimit(2)
                .cornerRadius(30)
            
            Picker(selection: $selectedMinute, label: Text("Choose minute").foregroundColor(.white)) {
                ForEach (0..<minuteAndSecondNumber.count) { index in
                    Text(self.minuteAndSecondNumber[index])
                }
            }.frame(maxWidth: 135)
            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            .cornerRadius(30)
            
            Picker(selection: $selectedSecond, label: Text("Choose second").foregroundColor(.white)) {
                ForEach (0..<minuteAndSecondNumber.count) { index in
                    Text(self.minuteAndSecondNumber[index])
                }
            }.frame(maxWidth: 135)
            .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            .cornerRadius(30)
        }
        .frame(width: 420)
        .pickerStyle(.wheel)
        Divider()
        //Text("You choose \(selectedHour):\(selectedMinute):\(selectedSecond)").font(.title)
    }
    static func generateHour() -> Array<String> {
        var arrayHours: Array<String> = []
        for index in 0..<24 {
            arrayHours.append(String(index))
        }
        return arrayHours
    }
    static func generateMinutesAndSecond() -> Array<String> {
        var arrayHours: Array<String> = []
        for index in 0..<60 {
            arrayHours.append(String(index))
        }
        return arrayHours
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(actionOfTimerIsStart: false)
    }
}
