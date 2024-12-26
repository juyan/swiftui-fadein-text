# swiftui-fadein-text

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

