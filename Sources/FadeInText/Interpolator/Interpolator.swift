import Foundation


/// Interpolator that specify the animation specs with regarding to how fast each chunk of text should fade in, and how fast each chunk of text should appear.
public protocol Interpolator {
  func interpolate(time: Double, previousResult: InterpolationResult) -> InterpolationResult
}

public struct InterpolationResult {
  /// The opacities for each text chunk
  public let opacities: [Double]
  
  /// Whether the animation should finish
  public let shouldAnimationFinish: Bool
}


