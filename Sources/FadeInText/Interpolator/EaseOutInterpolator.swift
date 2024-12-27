//
//  File.swift
//  
//
//  Created by Jun Yan on 12/26/24.
//

import Foundation

public final class EaseOutInterpolator: Interpolator {
  
  private let config: EaseOutInterpolatorConfig
  
  public init(config: EaseOutInterpolatorConfig) {
    self.config = config
  }
  
  public func interpolate(currentTime: Double, numberOfChunks: Int) -> InterpolationResult {
    if currentTime > config.appearanceDuration + config.fadeInDuration {
        return InterpolationResult(
            opacities: Array(repeating: 1.0, count: numberOfChunks),
            shouldAnimationFinish: true
        )
    }
    
    var newOpacities = [Double]()
    for i in 0 ..< numberOfChunks {
      let startTime = Double(i) * config.appearanceDuration / Double(numberOfChunks)
      
      let input = max(min(1.0, (currentTime - startTime) / config.fadeInDuration), 0.0)
      let newOpacity = cubicEaseOut(normalizedInput: input)
      newOpacities.append(newOpacity)
    }
    return InterpolationResult(opacities: newOpacities, shouldAnimationFinish: false)
  }
  
  private func cubicEaseOut(normalizedInput: Double) -> Double {
    return 1 - pow(1 - normalizedInput, 3)
  }
}

public struct EaseOutInterpolatorConfig {
    /// How long until a chunk of text is fully faded in
    public let fadeInDuration: Double
    /// How long until the last chunk of text starts to appear
    public let appearanceDuration: Double

    static let defaultValue = EaseOutInterpolatorConfig(fadeInDuration: 0.3, appearanceDuration: 1.0)
}
