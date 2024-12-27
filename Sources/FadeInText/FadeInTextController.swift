// FadeInTextController.swift
// Copyright (c) 2024 PacketFly Corporation
//

import Foundation
import SwiftUI

public class FadeInTextController: ObservableObject {
  @Published var text: AttributedString

  private let color: UIColor
  private let tokenizer: Tokenizer
  private let rawText: String
  private let interpolator: Interpolator

  private var displayLink: CADisplayLink?
  private var startTime: Double?
  private var chunks: [String] = []

  init(rawText: String, color: Color, tokenizer: Tokenizer, interpolator: Interpolator) {
    self.color = UIColor(color)
    let str = AttributedString(stringLiteral: rawText)
    let container = AttributeContainer([
      NSAttributedString.Key.foregroundColor: self.color.withAlphaComponent(0),
    ])
    text = str.settingAttributes(container)
    self.tokenizer = tokenizer
    self.rawText = rawText
    self.interpolator = interpolator
  }

  func startAnimation() {
    chunks = tokenizer.chunks(text: rawText)
    displayLink = CADisplayLink(target: self, selector: #selector(onFrameUpdate))
    displayLink?.preferredFrameRateRange = CAFrameRateRange(minimum: 30, maximum: 60, preferred: 60)
    displayLink?.add(to: RunLoop.main, forMode: .common)
    startTime = CACurrentMediaTime()
  }

  @objc
  private func onFrameUpdate(_: CADisplayLink) {
    guard let startTime, !self.chunks.isEmpty else {
      tearDownDisplayLink()
      return
    }
    let time = CACurrentMediaTime() - startTime
    let newResult = interpolator.interpolate(currentTime: time, numberOfChunks: chunks.count)
    var updatedString = AttributedString()
    for (i, chunk) in chunks.enumerated() {
      let container = AttributeContainer([
        NSAttributedString.Key.foregroundColor: color.withAlphaComponent(newResult.opacities[i]),
      ])
      let str = AttributedString(chunk, attributes: container)
      updatedString.append(str)
    }
    text = updatedString
    if newResult.shouldAnimationFinish {
      tearDownDisplayLink()
    }
  }

  private func tearDownDisplayLink() {
    displayLink?.invalidate()
    displayLink = nil
  }
}
