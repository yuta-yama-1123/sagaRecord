//
//  ContentView.swift
//  sagaRecord
//
//  Created by 山本祐太 on 2022/08/20.
//

import SwiftUI

struct ContentView: View {
    var testModel = CharacterControllModel()
    
    // 初期表示時処理
    init() {
        // キャラ名の一覧取得
        testModel.getCharNames()
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(testModel.names, id: \.self.id) { name in
                    NavigationLink(destination: DetailView(character: name)) {
                        Text(name.name)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Romancing Saga RS 育成メモ")
            .navigationBarItems(
                trailing:
                    Button(action: {
                        testModel.postAddTest()
                    }) {
                        Text("追加")
                            .font(
                                .system(
                                    size: 18,
                                    weight: .heavy,
                                    design: .rounded
                                )
                            )
                    }
            )
        }
    }
    
    struct DetailView : View {
        let character : CharactersModel.Names
        @State private var hitPoint: Int = 0
        var body: some View {
            VStack {
                Text(character.name + "のステータス")
                    .font(
                        .system(
                            size: 20,
                            weight: .heavy,
                            design: .rounded
                        )
                    )
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                HStack {
                    Text("ＨＰ：")
                        .fontWeight(.heavy)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                    Stepper(value: $hitPoint, in: 0...9999) {
                        Text(String(hitPoint))
                    }
                }
                HStack {
                    Text("腕力：")
                        .fontWeight(.heavy)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                    Stepper(value: $hitPoint, in: 0...9999) {
                        Text(String(hitPoint))
                    }
                }
                HStack {
                    Text("体力：")
                        .fontWeight(.heavy)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                    Stepper(value: $hitPoint, in: 0...9999) {
                        Text(String(hitPoint))
                    }
                }
                HStack {
                    Text("器用さ：")
                        .fontWeight(.heavy)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                    Stepper(value: $hitPoint, in: 0...9999) {
                        Text(String(hitPoint))
                    }
                }
                HStack {
                    Text("素早さ：")
                        .fontWeight(.heavy)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                    Stepper(value: $hitPoint, in: 0...9999) {
                        Text(String(hitPoint))
                    }
                }
                StatusStepperView(title: "知力", param: 100)
                StatusStepperView(title: "精神", param: 100)
                StatusStepperView(title: "愛", param: 100)
                StatusStepperView(title: "魅力", param: 100)
            }
            .padding()
            Button(action: {
                // do something
            }) {
                Text("保存")
                    .font(
                        .system(
                            size: 20,
                            weight: .heavy,
                            design: .rounded
                        )
                    )
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
    }
}
