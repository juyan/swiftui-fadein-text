// DefaultTokenizerTests.swift
// Copyright (c) 2024 PacketFly Corporation
//

@testable import FadeInText
import Foundation
import XCTest

final class DefaultTokenizerTests: XCTestCase {
  func test_tokenize_english() {
    let input = """
    Thanks to Swift's extended support for international languages and emoji, this works great no matter what kind of language you're using.

    This code prints out each character one at a time:
    """
    let tokenizer = DefaultTokenizer()
    let output = tokenizer.chunks(text: input)

    let expectedOutput = ["Thanks ", "to ", "Swift'", "s ", "extended ", "support ", "for ", "international ", "languages ", "and ", "emoji, ", "this ", "works ", "great ", "no ", "matter ", "what ", "kind ", "of ", "language ", "you'", "re ", "using.\n\n", "This ", "code ", "prints ", "out ", "each ", "character ", "one ", "at ", "a ", "time:"]

    XCTAssertEqual(expectedOutput.count, output.count)
    XCTAssertEqual(expectedOutput, output)
  }

  func test_tokenize_cjk() {
    let input = """
    壬戌之秋，七月既望，苏子与客泛舟游于赤壁之下。清风徐来，水波不兴。举酒属客，诵明月之诗，歌窈窕之章。
    """
    let tokenizer = DefaultTokenizer()
    let output = tokenizer.chunks(text: input)
    let expectedOutput = ["壬戌之秋，", "七月既望，", "苏子与客泛舟游于赤壁之下。", "清风徐来，", "水波不兴。", "举酒属客，", "诵明月之诗，", "歌窈窕之章。"]
    XCTAssertEqual(expectedOutput.count, output.count)
    XCTAssertEqual(expectedOutput, output)
  }
}
