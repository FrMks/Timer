//
//  ButtonsStartAndCancel.swift
//  Timer
//
//  Created by Максим Французов on 12.09.2021.
//

import SwiftUI

struct ButtonsStartAndCancel: View {
    @Binding var selectedHour: Int
    @Binding var selectedMinute: Int
    @Binding var selectedSecond: Int
    @Binding var actionOfTimerIsStart: Bool
    @Binding var totalTime: Int
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .strokeBorder(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)).opacity(0.8) ,lineWidth: 3)
                    .frame(width: 100, height: 100, alignment: .center)
                Button(action: {
                    selectedHour = 0
                    selectedMinute = 0
                    selectedSecond = 0
                }) {
                    Text("Cancel")
                }
                .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)).opacity(0.8))
                .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            }
            Spacer()
            ZStack {
                Circle()
                    .strokeBorder(Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)).opacity(0.8) ,lineWidth: 3)
                    .frame(width: 100, height: 100, alignment: .center)
                Button(action: {
                    if selectedHour != 0 || selectedMinute != 0 || selectedSecond != 0 {
                        totalTime = selectedHour * 60 * 60 + selectedMinute * 60 + selectedSecond
                        actionOfTimerIsStart.toggle()
                    }
                }) {
                    Text("Start") .font(.title)
                }
                .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)).opacity(0.8))
                .foregroundColor(Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)))
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            }
        }.padding()
    }
}

struct ButtonsStartAndCancel_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsStartAndCancel(selectedHour: .constant(0), selectedMinute: .constant(0), selectedSecond: .constant(0), actionOfTimerIsStart: .constant(false), totalTime: .constant(0))
    }
}
