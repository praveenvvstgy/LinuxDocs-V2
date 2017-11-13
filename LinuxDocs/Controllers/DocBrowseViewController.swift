//
//  DocBrowseViewController.swift
//  LinuxDocs
//
//  Created by Praveen Gowda I V on 11/12/17.
//  Copyright © 2017 Praveen Gowda I V. All rights reserved.
//

import UIKit
import WebKit

class DocBrowseViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var docLocation: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never

        // Do any additional setup after loading the view.
        if let docLocation = docLocation {
            webView.load(URLRequest(url: docLocation, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 0))
        } else {
            let alertController = UIAlertController(title: "Error Loading", message: "There was an error loading the documentation", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            present(alertController, animated: true, completion: nil)
        }
        webView.navigationDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DocBrowseViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard navigationAction.navigationType == .linkActivated else {
            decisionHandler(.allow)
            return
        }
        if let url = navigationAction.request.url, url.isFileURL {
            let pathComponents = url.pathComponents
            let directory = String(pathComponents[pathComponents.count - 2].suffix(4))
            var fileName = pathComponents[pathComponents.count - 1]
            fileName = String(fileName.prefix(upTo: fileName.index(fileName.endIndex, offsetBy: -5)))
            let docName = String(fileName.prefix(upTo: fileName.index(fileName.endIndex, offsetBy: -2)))
            if let location = Bundle.main.path(forResource: fileName, ofType: "html", inDirectory: directory) {
                let browser = DocBrowseViewController()
                browser.title = docName
                browser.docLocation = URL(fileURLWithPath: location)
                self.navigationController?.pushViewController(browser, animated: true)
            }
            decisionHandler(.cancel)
        } else {
            if let url = navigationAction.request.url {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            decisionHandler(.allow)
        }
    }
    
}
