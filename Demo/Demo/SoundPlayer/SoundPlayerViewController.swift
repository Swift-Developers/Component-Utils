//
//  SoundPlayerViewController.swift
//  Demo
//
//  Created by Lee on 2019/10/18.
//

import UIKit
import Utils

class SoundPlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "sound", withExtension: "m4a") {
            do {
                try SoundPlayer.play(url: url)
            } catch {
                print(error)
            }
        }
    }
    
    static func instance() -> Self {
        return StoryBoard.main.instance()
    }
}



