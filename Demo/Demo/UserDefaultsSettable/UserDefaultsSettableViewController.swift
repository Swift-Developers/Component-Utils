//
//  UserDefaultsSettableViewController.swift
//  Demo
//
//  Created by Lee on 2019/10/16.
//

import UIKit
import Utils

class UserDefaultsSettableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        UserDefaults.AppInfo.set(1, forKey: .launchCount)
        UserDefaults.AppInfo.set(2, forKey: .launchCount)
        UserDefaults.AppInfo.set(3, forKey: .launchCount)
        print(UserDefaults.AppInfo.integer(forKey: .launchCount))
        
//        UserDefaults.AppInfo.remove(forKey: .launchCount)
        UserDefaults.AppInfo.removeAll()
        print(UserDefaults.AppInfo.integer(forKey: .launchCount))
    }
}

/// 扩展 配置
extension UserDefaults {
    
    // 应用信息
    enum AppInfo: UserDefaultsSettable {
        enum Keys: String, UserDefaultsSettableKeys {
            case launchCount
            case firstLaunchTime
            case currentVersion
        }
    }
    
    // 配置信息
    enum ConfigInfo: UserDefaultsSettable {
        enum Keys: String, UserDefaultsSettableKeys {
            case config
            case update
            case splash
            
            // 随版本存储
            var build: String? {
                return "version"
            }
        }
    }
    
    // 用户信息
    enum AccountInfo: UserDefaultsSettable {
        enum Keys: String, UserDefaultsSettableKeys {
            case info
        }
    }
    
    // 设置信息
    enum SettingInfo: UserDefaultsSettable {
        enum Keys: String, UserDefaultsSettableKeys {
            case push
            case xxxx
            
            // 随用户存储
            var token: String? {
                return "userId"
            }
        }
    }
}

