// LinearInterpolator.swift
// Copyright (c) 2024 PacketFly Corporation
//

import Foundation

public final class LinearInterpolator: Interpolator {
    private let config: LinearInterpolatorConfig

    public init(config: LinearInterpolatorConfig) {
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
            let newOpacity = max(min(1.0, (currentTime - startTime) / config.fadeInDuration), 0.0)
            newOpacities.append(newOpacity)
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
