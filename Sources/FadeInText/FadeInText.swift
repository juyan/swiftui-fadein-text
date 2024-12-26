// FadeInText.swift
// Copyright (c) 2024 PacketFly Corporation
//

import SwiftUI

public struct FadeInText: View {
    @StateObject var controller: FadeInTextController

    public init(text: String, color: Color) {
        self.init(text: text, color: color, tokenizer: DefaultTokenizer(), interpolator: LinearInterpolator(config: .defaultValue))
    }

    public init(text: String, color: Color, tokenizer: Tokenizer, interpolator: Interpolator) {
        _controller = StateObject(
            wrappedValue: FadeInTextController(
                rawText: text,
                color: color,
                tokenizer: tokenizer,
                interpolator: interpolator
            )
        )
    }

    public var body: some View {
        Text(controller.text)
            .onAppear(perform: {
                controller.startAnimation()
            })
    }
}

#if DEBUG

    struct ControlledView: View {
        let text: String
        let config: LinearInterpolatorConfig
        @State var show = false

        var body: some View {
            VStack {
                if show {
                    FadeInText(text: text, color: .black, tokenizer: DefaultTokenizer(), interpolator: LinearInterpolator(config: config))
                        .font(.title2)
                }
                Spacer()
            }
            .padding(16)
            .onAppear(perform: {
                Task {
                    try await Task.sleep(nanoseconds: 2_000_000_000)
                    self.show = true
                }
            })
        }
    }

    #Preview("English") {
        ControlledView(
            text: "Hello! Welcome to FadeInText. The text will fade in smoothly. You are able to tweak the fade in duration by passing a configuration. Enjoy the animation.",
            config: .defaultValue
        )
    }

    #Preview("English-Slow") {
        ControlledView(
            text: "Hello! Welcome to FadeInText. The text will fade in smoothly. You are able to tweak the fade in duration by passing a configuration. Enjoy the animation.",
            config: .init(fadeInDuration: 2.0, appearanceDuration: 5.0)
        )
    }

    #Preview("Chinese") {
        ControlledView(
            text: "壬戌之秋，七月既望，苏子与客泛舟游于赤壁之下。清风徐来，水波不兴。举酒属客，诵明月之诗，歌窈窕之章。少焉，月出于东山之上，徘徊于斗牛之间。白露横江，水光接天。纵一苇之所如，凌万顷之茫然。浩浩乎如冯虚御风，而不知其所止；飘飘乎如遗世独立，羽化而登仙。",
            config: .init(fadeInDuration: 2.0, appearanceDuration: 5.0)
        )
    }
#endif
