// 
// Copyright 2021-2024 New Vector Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only OR LicenseRef-Element-Commercial
// Please see LICENSE files in the repository root for full details.
//

import Foundation
import MobileCoreServices

private class ShareExtensionItem: ShareItemProtocol {
    let itemProvider: NSItemProvider
    
    var loaded = false
    
    init(itemProvider: NSItemProvider) {
        self.itemProvider = itemProvider
    }
    
    var type: ShareItemType {
        if itemProvider.hasItemConformingToTypeIdentifier(MXKUTI.image.rawValue)
            || itemProvider.hasItemConformingToTypeIdentifier(MXKUTI.jpeg.rawValue)
            || itemProvider.hasItemConformingToTypeIdentifier(MXKUTI.png.rawValue) {
            return .image
        } else if itemProvider.hasItemConformingToTypeIdentifier(MXKUTI.video.rawValue) {
            return .video
        } else if itemProvider.hasItemConformingToTypeIdentifier(MXKUTI.movie.rawValue) {
            return .movie
        } else if itemProvider.hasItemConformingToTypeIdentifier(MXKUTI.fileUrl.rawValue) {
            return .fileURL
        } else if itemProvider.hasItemConformingToTypeIdentifier(MXKUTI.url.rawValue) {
            return .URL
        } else if itemProvider.hasItemConformingToTypeIdentifier(MXKUTI.text.rawValue) {
            return .text
        }
        
        return .unknown
    }
}

@objcMembers
public class ShareExtensionShareItemProvider: NSObject	 {
    
    public let items: [ShareItemProtocol]
    
    public init(extensionContext: NSExtensionContext) {
        
        var items: [ShareItemProtocol] = []
        for case let extensionItem as NSExtensionItem in extensionContext.inputItems {
            guard let attachments = extensionItem.attachments else {
                continue;
            }
            
            for itemProvider in attachments {
                items.append(ShareExtensionItem(itemProvider: itemProvider))
            }
        }
        self.items = items
    }
    
    public func areAllItemsLoaded() -> Bool {
        for case let item as ShareExtensionItem in self.items {
            if !item.loaded {
                return false
            }
        }
        
        return true
    }
    
    func areAllItemsImages() -> Bool {
        for case let item as ShareExtensionItem in self.items {
            if item.type != .image {
                return false
            }
        }
        
        return true
    }
    
    func loadItem(_ item: ShareItemProtocol, completion: @escaping (Any?, Error?) -> Void) {
        guard let shareExtensionItem = item as? ShareExtensionItem else {
            fatalError("[ShareExtensionShareItemProvider] Unexpected item type.")
        }
        
        let typeIdentifier = typeIdentifierForType(item.type)
        
        shareExtensionItem.loaded = false
        shareExtensionItem.itemProvider.loadItem(forTypeIdentifier: typeIdentifier, options: nil) { result, error in
            DispatchQueue.main.async {
                // Mark the item as loaded when back on the main queue to avoid
                // a race condition where the share extension sends duplicates.
                if error == nil {
                    shareExtensionItem.loaded = true
                }
                
                completion(result, error)
            }
        }
    }
    
    // MARK: - Private
    
    private func typeIdentifierForType(_ type: ShareItemType) -> String {
        switch type {
        case .text:
            return MXKUTI.text.rawValue
        case .URL:
            return MXKUTI.url.rawValue
        case .fileURL:
            return MXKUTI.fileUrl.rawValue
        case .image:
            return MXKUTI.image.rawValue
        case .video:
            return MXKUTI.video.rawValue
        case .movie:
            return MXKUTI.movie.rawValue
        default:
            return ""
        }
    }
}
