//
//  ViewController.swift
//  Demo
//
//  Created by Lee on 2019/10/15.
//

import UIKit
import Utils

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.present(UserDefaultsSettableViewController(), animated: true) {}
        }
    }
}

