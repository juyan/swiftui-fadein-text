import Foundation

public final class LinearInterpolator: Interpolator {
  
  private let config: LinearInterpolatorConfig
  
  public init(config: LinearInterpolatorConfig) {
    self.config = config
  }
  
  public func interpolate(time: Double, previousResult: InterpolationResult) -> InterpolationResult {
    guard previousResult.opacities.contains(where: { $0 < 1.0 }) else {
      return InterpolationResult(opacities: [], shouldAnimationFinish: true)
    }
    
    let opacityStep = min(1, FadeInTextController.refreshDuration / config.fadeInDuration)
    
    var newOpacities = [Double]()
    for i in 0..<previousResult.opacities.count {
      let prevOpacity = previousResult.opacities[i]
      if prevOpacity == 0 {
        let startTime = Double(i) * (config.appearanceDuration / Double(previousResult.opacities.count))
        if time > startTime {
          let newOpacity = min(1.0, (time - startTime) / config.fadeInDuration)
          newOpacities.append(newOpacity)
        } else {
          newOpacities.append(0)
        }
      } else {
        newOpacities.append(min(1.0, prevOpacity + opacityStep))
      }
    }
    return InterpolationResult(opacities: newOpacities, shouldAnimationFinish: false)
  }
}

public struct LinearInterpolatorConfig {
  /// How long until a chunk of text is fully faded in
  public let fadeInDuration: Double
  /// How long until the last chunk of text starts to appear
  public let appearanceDuration: Double
  
  static let defaultValue = LinearInterpolatorConfig(fadeInDuration: 0.3, appearanceDuration: 1.0)
}
