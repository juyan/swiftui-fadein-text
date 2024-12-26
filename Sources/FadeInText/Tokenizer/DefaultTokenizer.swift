// DefaultTokenizer.swift
// Copyright (c) 2024 PacketFly Corporation
//

import Foundation

/// A simple tokenizer that breaks down the text by whitespaces and punctuations
public final class DefaultTokenizer: Tokenizer {
    public func chunks(text: String) -> [String] {
        var indexes: [String.Index] = []
        var index = text.startIndex
        while index < text.endIndex {
            let char = text[index]
            if char.isWhitespace || char.isPunctuation {
                indexes.append(index)
            }
            index = text.index(after: index)
        }

        // Make sure there are no consecutive indexes
        var dedupedIndexes: [String.Index] = []
        for i in 0 ..< indexes.count {
            if i == indexes.count - 1 {
                dedupedIndexes.append(indexes[i])
            } else {
                let currentIndex = indexes[i]
                let nextIndex = indexes[i + 1]
                if text.index(after: currentIndex) == nextIndex {
                    continue
                } else {
                    dedupedIndexes.append(currentIndex)
                }
            }
        }

        var results = [String]()
        var previousIndex = text.startIndex
        for dedupedIndex in dedupedIndexes {
            let part = text[previousIndex ... dedupedIndex]
            results.append(String(part))
            previousIndex = text.index(after: dedupedIndex)
        }
        return results
    }
}
