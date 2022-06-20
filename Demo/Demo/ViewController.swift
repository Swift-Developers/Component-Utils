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
        
    }
    
    @IBAction func stackAction(_ sender: UITapGestureRecognizer) {
        let index = sender.view?.subviewIndex(tap: sender)
        switch index {
        case 0: // 地址
            let controller = AddressPickerController.instance { (code) in
                print("已选择地址邮编: \(code)")
                print("已选择地址名称: " + (Address.get(name: code) ?? "空"))
            }
            controller.show(in: self, animated: true)
            
        case 1: // 定位
            print("定位权限: \(Locator.isEnabled ? "已开启" : "未开启")")
            Locator.shared.get { (result) in
                switch result {
                case .success(let value):
                    print("定位成功: \(value)")
                    
                case .failure(let error):
                    print("定位失败: \(error)")
                }
            }
            
            break
            
        case 2: // 声音播放
            let controller = SoundPlayerViewController.instance()
            present(controller, animated: true) { }

        case 3:
            let controller = InsetLabelViewController.instance()
            present(controller, animated: true) { }
            
        case 4:
            let controller = PanAnimationViewController.instance()
            navigationController?.pushViewController(controller, animated: true)
            
        default: break
        }
    }
}

fileprivate extension UIView {
    
    func subviewIndex(tap: UITapGestureRecognizer) -> Int? {
        let point = tap.location(in: self)
        return subviews.firstIndex { $0.frame.contains(point) }
    }
}
