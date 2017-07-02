//
//  BookingWebViewController.swift
//  Cathay Cinema
//
//  Created by Amit Sachdeva on 3/7/17.
//  Copyright © 2017 Amit Sachdeva. All rights reserved.
//

import UIKit
import KVNProgress

class BookingWebViewController: UIViewController {

    @IBOutlet var bookingWebView:UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIWebView.loadRequest(self.bookingWebView)(NSURLRequest(url: NSURL(string: Constant.URL.bookingUrl)! as URL) as URLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: IBAction Methods
    @IBAction func back(button: UIButton) {
        if self.bookingWebView.canGoBack {
            self.bookingWebView.goBack()
        }
    }
    
    @IBAction func forward(button: UIButton) {
        if self.bookingWebView.canGoForward {
            self.bookingWebView.goForward()
        }
    }
}

extension BookingWebViewController:UIWebViewDelegate {

    func webViewDidStartLoad(_ webView: UIWebView) {
        KVNProgress.show()
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        KVNProgress.dismiss(completion: {
            KVNProgress.showError()
        })
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        KVNProgress.dismiss(completion: {
            
        })
    }
   
}
