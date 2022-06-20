//
//  PanAnimationViewController.swift
//  Demo
//
//  Created by 方林威 on 2022/6/20.
//

import UIKit
import Utils

class PanAnimationViewController: UIViewController {
    
    private lazy var ballView = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ballView.textColor = .white
        ballView.text = "拖动我"
        ballView.textAlignment = .center
        view.backgroundColor = .white
        view.addSubview(ballView)
        ballView.backgroundColor = .blue
        ballView.frame = .init(x: 0, y: 100, width: 80, height: 80)
        ballView.panAnimation.isEnabled = true
        // 磁吸附
//        ballView.panAnimation.mode = .suction(.left)
//        ballView.panAnimation.mode = .suction(.horizontal)
        ballView.panAnimation.mode = .suction(.all)
        // 紧贴
//        ballView.panAnimation.mode = .adsorption(.left)
//        ballView.panAnimation.mode = .adsorption(.top)
        // 监听状态
        ballView.panAnimation.touch = { state in
            print("拖动状态\(state)")
        }
    }
    
    static func instance() -> PanAnimationViewController {
        return PanAnimationViewController()
    }
}





