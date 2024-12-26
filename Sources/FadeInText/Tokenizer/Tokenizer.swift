import Foundation

/// A protocol that decides how to break down a given string into chunks for animation purpose
public protocol Tokenizer {
  
  /// Break down the given text into chunks
  /// - Parameter text: The given text
  /// - Returns: An array of text chunks
  func chunks(text: String) -> [String]
}
