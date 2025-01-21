# swiftui-fadein-text

![Apache 2.0 License](https://img.shields.io/github/license/juyan/swiftui-fadein-text)
![Package Releases](https://img.shields.io/github/v/release/juyan/swiftui-fadein-text)
![Build Results](https://img.shields.io/github/actions/workflow/status/juyan/swiftui-fadein-text/.github/workflows/swift.yml?branch=main)
![Swift Version](https://img.shields.io/badge/swift-5.5-critical)
![Supported Platforms](https://img.shields.io/badge/platform-iOS%2015%20-lightgrey)

## What
A SwiftUI based fade-in text animation that works for iOS 15 and above.

## Why
It's surprisingly difficult/clumsy to build smooth fade-in text animation in SwiftUI prior to iOS 18 TextRenderer APIs. 

## How
This approach uses `AttributedString` to achieve a smooth opacity transition over the given time.

It is also designed to be highly customizable so that you can introduce your own logic on how to tokenize the string or interpolate the animation.

## Quick Start
```swift
import FadeInText

struct MyView: View {
  let text: String
  var body: some View {
    FadeInText(text: text, color: .black, tokenizer: DefaultTokenizer(), interpolator: LinearInterpolator(config: .defaultValue))
  }
}
```

Animation Preview:

https://github.com/user-attachments/assets/a2744e7b-b7cf-4952-a174-d130a308437c

## FAQ

### Why not simply use `.opacity(value)`?

In order to animate with different opacity values for different parts of the text, it would require iOS 17 minimum target.

```swift
  var body: some View {
    var text = Text("")
    for chu in chunk {
      if #available(iOS 17.0, *) {
        text = text + Text(chu).foregroundStyle(.red.opacity(0.5))
      } else {
        // Fallback on earlier versions
      }
    }
    return text
  }
```
### Why not use [textrenderer](https://developer.apple.com/documentation/swiftui/view/textrenderer(_:)) ?

It requires iOS 18 minimum target.

### 

