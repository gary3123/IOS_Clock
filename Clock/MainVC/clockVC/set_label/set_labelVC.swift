//
//  set_labelVC.swift
//  Clock
//
//  Created by 阿瑋 on 2022/8/10.
//

import UIKit

class label_text : NSObject {
    var label = "Alarm"
    static let shareinstance = label_text()
    private override init() {
    }
}

class set_labelVC: UIViewController {

    @IBOutlet weak var label_tf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        label_tf.text! = label_text.shareinstance.label
    }

    @IBAction func back(_ sender: Any) {
        label_text.shareinstance.label =  label_tf.text!
        self.navigationController?.popViewController(animated: true)
    }

}
