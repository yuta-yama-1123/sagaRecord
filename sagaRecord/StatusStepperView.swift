//
//  StatusStepperView.swift
//  sagaRecord
//
//  Created by 山本祐太 on 2022/08/23.
//

import SwiftUI

struct StatusStepperView: View {
    @State var title: String
    @State var param: Int
    var body: some View {
        HStack {
            Text(title + "：")
                .fontWeight(.heavy)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            Stepper(value: $param, in: 0...9999) {
                Text(String(param))
            }
        }
    }
}

struct StatusStepperView_Previews: PreviewProvider {
    static var previews: some View {
        StatusStepperView(title: "title", param: 123)
    }
}
