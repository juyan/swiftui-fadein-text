import Foundation
import SwiftUI


public class FadeInTextController: ObservableObject {
    
  @Published var text: AttributedString
  
  private let color: UIColor
  private let tokenizer: Tokenizer
  private let rawText: String
  private let interpolator: Interpolator
  
  public static let refreshDuration = 0.05
  
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
    let chunks = tokenizer.chunks(text: rawText)
    
    Task {
      var currentTime = 0.0
      var interpolationResult = InterpolationResult(opacities: Array(repeating: 0, count: chunks.count), shouldAnimationFinish: false)

      while true {
        do {
          try await Task.sleep(nanoseconds: UInt64(Self.refreshDuration * 1000 * 1000 * 1000))
        } catch {}
        currentTime += Self.refreshDuration
        let newResult = interpolator.interpolate(time: currentTime, previousResult: interpolationResult)
        if newResult.shouldAnimationFinish {
          break
        } else {
          interpolationResult = newResult
        }
        var updatedString = AttributedString()
        for (i, chunk) in chunks.enumerated() {
          let container = AttributeContainer([
            NSAttributedString.Key.foregroundColor: self.color.withAlphaComponent(newResult.opacities[i])
          ])
          let str = AttributedString(chunk, attributes: container)
          updatedString.append(str)
        }
        await updateText(newText: updatedString)
      }
    }
  }
  
  @MainActor
  private func updateText(newText: AttributedString) {
    self.text = newText
  }
}
