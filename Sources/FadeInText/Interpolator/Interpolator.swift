import Foundation


/// Interpolator that specify the animation specs with regarding to how fast each chunk of text should fade in, and how fast each chunk of text should appear.
public protocol Interpolator {
  
  /// Calculate the interpolation result.
  /// - Parameters:
  ///   - currentTime: The current time, relative to the animation start time.
  ///   - numberOfChunks: The total number of text chunks.
  /// - Returns: The interpolation result
  func interpolate(currentTime: Double, numberOfChunks: Int) -> InterpolationResult
}

public struct InterpolationResult {
  /// The opacities for each text chunk
  public let opacities: [Double]
  
  /// Whether the animation should finish
  public let shouldAnimationFinish: Bool
}


