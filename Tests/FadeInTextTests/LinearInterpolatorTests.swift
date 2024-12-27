// LinearInterpolatorTests.swift
// Copyright (c) 2024 PacketFly Corporation
//

@testable import FadeInText
import Foundation
import XCTest

class LinearInterpolatorTests: XCTestCase {
  func test_interpolation() {
    let interpolator = LinearInterpolator(config: .init(fadeInDuration: 0.4, appearanceDuration: 3))

    var result = interpolator.interpolate(currentTime: 0, numberOfChunks: 5)
    XCTAssertFalse(result.shouldAnimationFinish)
    XCTAssertTrue(result.opacities.allSatisfy { $0 == 0.0 })

    result = interpolator.interpolate(currentTime: 0.3, numberOfChunks: 5)
    XCTAssertFalse(result.shouldAnimationFinish)
    XCTAssertTrue(result.opacities.first! > 0)
    XCTAssertTrue(result.opacities.filter { $0 == 0.0 }.count == 4)
  }
}
