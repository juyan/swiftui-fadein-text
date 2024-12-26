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
      NSAttributedString.Key.foregroundColor: self.color.withAlphaComponent(0)
    ])
    self.text = str.settingAttributes(container)
    self.tokenizer = tokenizer
    self.rawText = rawText
    self.interpolator = interpolator
  }
    
  func startAnimation() {
    self.chunks = tokenizer.chunks(text: rawText)
    self.displayLink = CADisplayLink(target: self, selector: #selector(onFrameUpdate))
    self.displayLink?.preferredFrameRateRange = CAFrameRateRange(minimum: 30, maximum: 60, preferred: 60)
    self.displayLink?.add(to: RunLoop.main, forMode: .common)
    startTime = CACurrentMediaTime()
  }
  
  @objc
  private func onFrameUpdate(_ displayLink: CADisplayLink) {
    guard let startTime, !self.chunks.isEmpty else {
      return
    }
    let time = CACurrentMediaTime() - startTime
    let newResult = interpolator.interpolate(currentTime: time, numberOfChunks: self.chunks.count)
    var updatedString = AttributedString()
    for (i, chunk) in chunks.enumerated() {
      let container = AttributeContainer([
        NSAttributedString.Key.foregroundColor: self.color.withAlphaComponent(newResult.opacities[i])
      ])
      let str = AttributedString(chunk, attributes: container)
      updatedString.append(str)
    }
    self.text = updatedString
    if newResult.shouldAnimationFinish {
      self.displayLink?.invalidate()
      self.displayLink = nil
    }
  }
}
