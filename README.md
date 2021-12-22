# QuickLook Preview for SwiftUI on Mac Catalyst

According to the documentation for [`QLPreviewController`](https://developer.apple.com/documentation/quicklook/qlpreviewcontroller):
> For Mac apps built with Mac Catalyst, presenting a `QLPreviewController` displays the preview in a [`QLPreviewPanel`](https://developer.apple.com/documentation/quicklookui/qlpreviewpanel) and dims the previously active window.

This package provides a way to present the preview that doesn't dim the window.

⚠️ This package is designed for and only tested on Mac Catalyst apps.



## Basic Usage

```swift
.quickLookPreview(_ items: Binding<[QuickLookPreviewItem]>, at index: Binding<Int> = Binding<Int>.constant(0))
```

Add the line above to a view. When `$items` is populated with `QuickLookPreviewItem`s, the preview is presented.

## Full Example

Note that the example uses files named `1.png`, `2.png`, and `3.png` in the Xcode project.

```swift
import SwiftUI

struct ContentView: View {
    @State private var items: [QuickLookPreviewItem] = []
    @State private var index = 0
    
    var body: some View {
        ZStack {
            Button("Present QuickLook Preview") {
                // Workaround needed because there's no way to know when the preview window is dismissed.
                if self.items.isEmpty {
                    fillItems()
                } else {
                    Task {
                        self.items = []
                        do { try await Task.sleep(nanoseconds: 0) } catch { fillItems() }
                        fillItems()
                    }
                }
            }
        }
        .quickLookPreview(self.$items, at: self.$index)
    }
    
    func fillItems() {
        self.items = [
            QuickLookPreviewItem(url: Bundle.main.url(forResource: "1", withExtension: "png")!, title: "No. 1"),
            QuickLookPreviewItem(url: Bundle.main.url(forResource: "2", withExtension: "png")!, title: "No. 2"),
            QuickLookPreviewItem(url: Bundle.main.url(forResource: "3", withExtension: "png")!, title: "No. 3"),
        ]
        self.index = 2
    }
}
```
