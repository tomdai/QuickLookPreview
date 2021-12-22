import SwiftUI
import QuickLook

public extension View {
    func quickLookPreview(_ items: Binding<[QuickLookPreviewItem]>, at index: Binding<Int> = Binding<Int>.constant(0)) -> some View {
        background {
            if !items.isEmpty {
                QuickLookPreview(items: items, index: index)
                    .opacity(0)
            }
        }
    }
}

public class QuickLookPreviewItem: NSObject, QLPreviewItem {
    public var previewItemURL: URL?
    public var previewItemTitle: String?
    
    public init(url: URL, title: String) {
        self.previewItemURL = url
        self.previewItemTitle = title
    }
}

fileprivate struct QuickLookPreview: UIViewControllerRepresentable {
    @Binding var items: [QuickLookPreviewItem]
    @Binding var index: Int

    public func makeUIViewController(context: Context) -> UIViewController {
        let qlPreviewController = QLPreviewController()
        qlPreviewController.dataSource = context.coordinator
        qlPreviewController.currentPreviewItemIndex = index
        let uiNavigationController = UINavigationController(rootViewController: qlPreviewController)
        return uiNavigationController
    }

    public func updateUIViewController(_: UIViewController, context _: Context) { }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    public class Coordinator: QLPreviewControllerDataSource {
        let parent: QuickLookPreview

        public init(parent: QuickLookPreview) {
            self.parent = parent
        }

        public func numberOfPreviewItems(in what: QLPreviewController) -> Int {
            return self.parent.$items.count
        }

        public func previewController(_: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            return parent.items[index]
        }
    }
}
