//
//  ShareViewController.swift
//  Share
//
//  Created by Andrew Malyarchuk on 11.02.2018.
//  Copyright © 2018 wonderbeard. All rights reserved.
//

import UIKit
import MobileCoreServices

enum ShareError: Error {
    case emptyData
    case cancel
}

class ShareViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Processing..."
        let item = extensionContext?.inputItems.first as! NSExtensionItem
        let title = item.attributedTitle?.string
        let content = item.attributedContentText?.string
        let attachment = item.attachments?.first as! NSItemProvider
        guard attachment.hasItemConformingToTypeIdentifier(kUTTypeURL as String) else {
            extensionContext?.cancelRequest(withError: ShareError.emptyData)
            return
        }
        attachment.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil) { (value, error) in
            switch (value, error) {
            case (_, let error as Error):
                self.label.text = "Error"
                self.cancel(after: 3)
            case (let url as NSURL, _):
                self.label.text = url.absoluteString
                self.finish(after: 3)
            case (let urlString as String, _):
                self.label.text = urlString
                self.finish(after: 3)
            default:
                self.label.text = "Error"
                self.cancel(after: 3)
            }
        }
    }
    
    private func cancel(after delay: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [extensionContext] in
            extensionContext?.cancelRequest(withError: ShareError.cancel)
        }
    }
    
    private func finish(after delay: TimeInterval) {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            UIView.animate(
                withDuration: 0.4,
                delay: delay,
                animations: {
                    self.view.alpha = 0
                },
                completion: { _ in
                    self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
                }
            )
        }
        
    }
    
    @IBAction func tapDone(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func tapCancel(_ sender: UIBarButtonItem) {
    }
    
}

