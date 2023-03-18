//
//  AlertViewController.swift
//  WebView
//
//  Created by Kim Nghĩa on 07/03/2023.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertTitle: UILabel!
    @IBOutlet weak var alertName: UILabel!
    @IBOutlet weak var alertInfo: UILabel!
    @IBOutlet weak var alertHotline: UILabel!
    @IBOutlet weak var alertEmail: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config() {
        alertView.layer.cornerRadius = 5
        closeButton.backgroundColor = ResourceColor.headerView
        closeButton.setTitle(ResourceText.commonClose.localizedString(), for: .normal)
        alertTitle.text = ResourceText.commonInfo.localizedString()
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.layer.cornerRadius = 5
        alertView.layer.borderWidth = 2
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
