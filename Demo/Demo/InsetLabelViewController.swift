//
//  InsetLabelViewController.swift
//  Demo
//
//  Created by 方林威 on 2022/6/20.
//

import UIKit
import Utils

class InsetLabelViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.edgeInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    static func instance() -> Self {
        return StoryBoard.main.instance()
    }
}





